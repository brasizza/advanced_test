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
    required this.photo,
    required this.position,
    required this.isConfirmed,
    required this.confirmationData,
  });

  String get initials {
    final names = name.split(' ');

    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar'.toUpperCase();
  }
}

void main() {
  test('should return the first letter of the first and last names', () async {
    final player = NexEventPlayer(
      id: '',
      name: 'Marcus Brasizza',
      photo: '',
      position: '',
      isConfirmed: true,
      confirmationData: DateTime.now(),
    );

    expect(player.initials, 'MB');

    final player2 = NexEventPlayer(
      id: '',
      name: 'Kleber Bambam',
      photo: '',
      position: '',
      isConfirmed: true,
      confirmationData: DateTime.now(),
    );

    expect(player2.initials, 'KB');

    final player3 = NexEventPlayer(
      id: '',
      name: 'Ingrid Mota Silva',
      photo: '',
      position: '',
      isConfirmed: true,
      confirmationData: DateTime.now(),
    );

    expect(player3.initials, 'IS');

    //Act

    //Assert
  });
}
