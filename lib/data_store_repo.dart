abstract interface class DataStoreRepo<TUid, TUids, TValue, TArgs> {
  Future<void> put(TValue value, TArgs args);

  Future<void> putAll(List<TValue> values, TArgs args);

  Future<void> delete(TUid uid, TArgs args);

  Future<void> deleteAll(List<TUid> uids, TArgs args);

  Future<void> deleteValues(TUids uids, TArgs args);

  Future<void> deleteAllValues(List<TUids> uids, TArgs args);

  Future<void> clear(TArgs args);
}

class DataStoreRepoEmpty<TUid, TUids, TValue, TArgs> implements DataStoreRepo<TUid, TUids, TValue, TArgs> {
  @override
  Future<void> put(TValue value, TArgs args) async {}

  @override
  Future<void> putAll(List<TValue> values, TArgs args) async {}

  @override
  Future<void> delete(TUid uid, TArgs args) async {}

  @override
  Future<void> deleteAll(List<TUid> uids, TArgs args) async {}

  @override
  Future<void> deleteValues(TUids uids, TArgs args) async {}

  @override
  Future<void> deleteAllValues(List<TUids> uids, TArgs args) async {}

  @override
  Future<void> clear(TArgs args) async {}
}
