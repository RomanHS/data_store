import 'dart:async';
import 'dart:collection';

class StoreRAM<TUid, TUids, TValue> {
  final LinkedHashMap<TUid, TValue> _map;
  final LinkedHashMap<TUids, LinkedHashMap<TUid, TValue>> _mapList;
  final TUid Function(TValue) getUid;
  final Iterable<TUids> Function(TValue)? getUids;

  late final StreamController<TValue> _streamController = StreamController.broadcast();

  StoreRAM({
    required Iterable<TValue> values,
    required this.getUid,
    this.getUids,
  })  : _map = LinkedHashMap(),
        _mapList = LinkedHashMap() {
    for (TValue value in values) {
      _map[getUid(value)] = value;

      for (TUids uids in getUids?.call(value) ?? const []) {
        _mapList.putIfAbsent(uids, () => LinkedHashMap())[getUid(value)] = value;
      }
    }
  }

  bool get isEmpty => _map.isEmpty;

  bool get isNotEmpty => _map.isNotEmpty;

  int get length => _map.length;

  Iterable<TValue> get values => _map.values;

  Stream<TValue> get stream => _streamController.stream;

  TValue? get(TUid uid) => _map[uid];

  Iterable<TValue> getValues(TUids uids) => _mapList[uids]?.values ?? const [];

  Iterable<TTValue> getValuesType<TTValue extends TValue>() => _mapList[TTValue]?.values.whereType<TTValue>() ?? const [];

  int getLength(TUids uids) => _mapList[uids]?.length ?? 0;

  int getLengthType<TTValue extends TValue>() => _mapList[TTValue]?.length ?? 0;

  void put(TValue value) {
    final TValue? valueOld = _map[getUid(value)];

    if (valueOld != null) {
      for (TUids uids in getUids?.call(valueOld) ?? const []) {
        _mapList[uids]?.remove(getUid(valueOld));
      }
    }

    _map[getUid(value)] = value;

    for (TUids uids in getUids?.call(value) ?? const []) {
      _mapList.putIfAbsent(uids, () => LinkedHashMap())[getUid(value)] = value;
    }

    _streamController.add(value);
  }

  void putAll(Iterable<TValue> values) {
    for (TValue value in values) {
      put(value);
    }
  }

  void delete(TUid uid) {
    final TValue? value = _map.remove(uid);

    if (value != null) {
      for (TUids uids in getUids?.call(value) ?? const []) {
        _mapList[uids]?.remove(getUid(value));
      }

      _streamController.add(value);
    }
  }

  void deleteAll(Iterable<TUid> uids) {
    for (TUid uid in uids) {
      delete(uid);
    }
  }

  void deleteValues(TUids uids) {
    for (TValue value in _mapList.remove(uids)?.values ?? const []) {
      _map.remove(getUid(value));

      _streamController.add(value);
    }
  }

  void deleteAllValues(Iterable<TUids> uids) {
    for (TUids uid in uids) {
      deleteValues(uid);
    }
  }

  void clear() {
    for (TValue value in values) {
      _streamController.add(value);
    }

    _map.clear();

    _mapList.clear();
  }

  Future<void> dispose() => _streamController.close();
}
