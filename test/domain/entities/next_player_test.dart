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
    return names[0][0] + names[1][0];
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

    var initials = player.initials;
    expect(initials, 'MB');

    //Act

    //Assert
  });
}
