import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class NextEventLoader {
  final LoadNextEventRepository _repository;
  NextEventLoader({required LoadNextEventRepository repository}) : _repository = repository;
  Future<void> call({required String groupId}) async {
    await _repository.loadNextEvent(groupId: groupId);
  }
}

class LoadNextEventRepository {
  var callsCount = 0;
  String? groupId;
  Future<void> loadNextEvent({required String groupId}) async {
    callsCount++;
    this.groupId = groupId;
  }
}

void main() {
  test('should load event data from a repository', () async {
    final groupId = Random().nextInt(9999).toString();
    final repo = LoadNextEventRepository();
    final sut = NextEventLoader(repository: repo);
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
}
