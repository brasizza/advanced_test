class NexEventPlayer {
  final String id;
  final String initials;
  final String name;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationData;

  NexEventPlayer._({
    required this.id,
    required this.name,
    required this.initials,
    this.photo,
    this.position,
    required this.isConfirmed,
    this.confirmationData,
  });

  factory NexEventPlayer({
    required String id,
    required String name,
    String? photo,
    String? position,
    required bool isConfirmed,
    DateTime? confirmationData,
  }) =>
      NexEventPlayer._(
        id: id,
        name: name,
        initials: _getInitials(name),
        photo: photo,
        position: position,
        isConfirmed: isConfirmed,
        confirmationData: confirmationData,
      );

  static String _getInitials(String name) {
    final names = name.toUpperCase().trim().split(' ');
    if (names.length == 1) {
      if (names.first.length == 1) {
        return names.first[0];
      } else if (names.first.isEmpty) {
        return '-';
      }
      return names[0][0] + names[0][1];
    }
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar';
  }
}
