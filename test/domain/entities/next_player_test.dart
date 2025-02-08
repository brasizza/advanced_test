import 'package:flutter_test/flutter_test.dart';

class NexEventPlayer {
  final String id;
  final String name;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationData;

  NexEventPlayer({
    required this.id,
    required this.name,
    this.photo,
    this.position,
    required this.isConfirmed,
    this.confirmationData,
  });

  String get initials {
    final names = name.split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar'.toUpperCase();
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
}
