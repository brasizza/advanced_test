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
  NexEventPlayer makeSut(String name) => NexEventPlayer(
        id: '',
        name: name,
        isConfirmed: true,
      );
  test('should return the first letter of the first and last names', () async {
    final sut = makeSut('Marcus Brasizza');
    expect(sut.initials, 'MB');
    final sut2 = makeSut('Kleber Bambam');
    expect(sut2.initials, 'KB');
    final sut3 = makeSut('Ingrid Mota Silva');
    expect(sut3.initials, 'IS');
  });
}
