import 'package:flutter_test/flutter_test.dart';

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
    final names = name.toUpperCase().split(' ');
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

void main() {
  String initialsOf(String name) => NexEventPlayer(
        id: '',
        name: name,
        isConfirmed: true,
      ).initials;
  test('should return the first letter of the first and last names', () async {
    expect(initialsOf('Marcus Brasizza'), 'MB');
    expect(initialsOf('Kleber Bambam'), 'KB');
    expect(initialsOf('Ingrid Mota Silva'), 'IS');
  });

  test('should return the first letters of the first name', () async {
    expect(initialsOf('Kleber'), 'KL');
    expect(initialsOf('R'), 'R');
    expect(initialsOf(''), '-');
  });

  test('should convert to uppercase', () async {
    expect(initialsOf('marcus brasizza'), 'MB');
    expect(initialsOf('kleber bambam'), 'KB');
    expect(initialsOf('r'), 'R');
    expect(initialsOf('ingrid mota silva'), 'IS');
  });
}
