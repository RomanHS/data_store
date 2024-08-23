abstract interface class DataStoreRepo<TUid, TUids, TValue> {
  Future<void> put(TValue value);

  Future<void> putAll(List<TValue> values);

  Future<void> delete(TUid uid);

  Future<void> deleteAll(List<TUid> uids);

  Future<void> deleteValues(TUids uids);

  Future<void> deleteAllValues(List<TUids> uids);

  Future<void> clear();
}

class DataStoreRepoEmpty<TUid, TUids, TValue> implements DataStoreRepo<TUid, TUids, TValue> {
  @override
  Future<void> put(TValue value) async {}

  @override
  Future<void> putAll(List<TValue> values) async {}

  @override
  Future<void> delete(TUid uid) async {}

  @override
  Future<void> deleteAll(List<TUid> uids) async {}

  @override
  Future<void> deleteValues(TUids uids) async {}

  @override
  Future<void> deleteAllValues(List<TUids> uids) async {}

  @override
  Future<void> clear() async {}
}
