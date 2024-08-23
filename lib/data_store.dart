library data_store;

import 'package:data_store/action.dart';
import 'package:data_store/store_ram.dart';
import 'package:data_store/data_store_repo.dart';

class DataStore<TUid, TUids, TValue> {
  final DataStoreRepo<TUid, TUids, TValue> _repo;
  final StoreRAM<TUid, TUids, TValue> _store;

  const DataStore({
    required DataStoreRepo<TUid, TUids, TValue> repo,
    required StoreRAM<TUid, TUids, TValue> store,
  })  : _repo = repo,
        _store = store;

  DataStore.create({
    required DataStoreRepo<TUid, TUids, TValue> repo,
    required List<TValue> values,
    required TUid Function(TValue) getUid,
    Iterable<TUids> Function(TValue)? getUids,
  })  : _repo = repo,
        _store = StoreRAM<TUid, TUids, TValue>(
          values: values,
          getUid: getUid,
          getUids: getUids,
        );

  DataStore.empty({
    required TUid Function(TValue) getUid,
  })  : _repo = DataStoreRepoEmpty(),
        _store = StoreRAM<TUid, TUids, TValue>(
          values: const [],
          getUid: getUid,
        );

  bool get isEmpty => _store.isEmpty;

  bool get isNotEmpty => _store.isNotEmpty;

  int get length => _store.length;

  Iterable<TValue> get values => _store.values;

  Stream<TValue> get stream => _store.stream;

  TValue? get(TUid uid) => _store.get(uid);

  Iterable<TValue> getValues(TUids uids) => _store.getValues(uids);

  Iterable<TTValue> getValuesType<TTValue extends TValue>() => _store.getValuesType<TTValue>();

  int getLength(TUids uids) => _store.getLength(uids);

  int getLengthType<TTValue extends TValue>() => _store.getLengthType<TTValue>();

  Action put(TValue value) => Action(goToDB: () => _repo.put(value), goToRAM: () => _store.put(value));

  Action putAll(List<TValue> values) => Action(goToDB: () => _repo.putAll(values), goToRAM: () => _store.putAll(values));

  Action delete(TUid uid) => Action(goToDB: () => _repo.delete(uid), goToRAM: () => _store.delete(uid));

  Action deleteAll(List<TUid> uids) => Action(goToDB: () => _repo.deleteAll(uids), goToRAM: () => _store.deleteAll(uids));

  Action deleteValues(TUids uids) => Action(goToDB: () => _repo.deleteValues(uids), goToRAM: () => _store.deleteValues(uids));

  Action deleteAllValues(List<TUids> uids) => Action(goToDB: () => _repo.deleteAllValues(uids), goToRAM: () => _store.deleteAllValues(uids));

  Action clear() => Action(goToDB: () => _repo.clear(), goToRAM: () => _store.clear());

  Future<void> dispose() => _store.dispose();
}
