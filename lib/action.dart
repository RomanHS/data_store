class Action {
  final Future<void> Function() _goToDB;
  final void Function() _goToRAM;

  const Action({
    required Future<void> Function() goToDB,
    required void Function() goToRAM,
  })  : _goToDB = goToDB,
        _goToRAM = goToRAM;

  Future<void> go() => _goToDB().then((void _) => _goToRAM());

  static Future<void> transaction(List<Action> actions, Future<void> Function(Future<void> Function()) transaction) => transaction.call(() async {
        for (Action action in actions) {
          await action._goToDB();
        }
      }).then((void _) {
        for (Action action in actions) {
          action._goToRAM();
        }
      });
}
