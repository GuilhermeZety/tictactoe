enum PlayerType {
  host,
  opponent;

  String get name {
    switch (this) {
      case PlayerType.host:
        return 'host';
      case PlayerType.opponent:
        return 'opponent';
    }
  }

  factory PlayerType.fromString(String name) {
    switch (name) {
      case 'host':
        return PlayerType.host;
      case 'opponent':
        return PlayerType.opponent;
      default:
        throw Exception('Invalid name');
    }
  }
}
