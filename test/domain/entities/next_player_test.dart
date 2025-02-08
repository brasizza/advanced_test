import 'package:advanced_test/domain/entities/next_player_event.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });

  test('should return - when name is empty', () async {
    expect(initialsOf(''), '-');
  });

  test('should convert to uppercase', () async {
    expect(initialsOf('marcus brasizza'), 'MB');
    expect(initialsOf('kleber bambam'), 'KB');
    expect(initialsOf('r'), 'R');
    expect(initialsOf('ingrid mota silva'), 'IS');
  });

  test('should ignore extra white spaces', () async {
    expect(initialsOf('Marcus Brasizza '), 'MB');
    expect(initialsOf(' Marcus Brasizza'), 'MB');
    expect(initialsOf('  Marcus      Brasizza  '), 'MB');
    expect(initialsOf('r '), 'R');
    expect(initialsOf('  '), '-');
  });
}
