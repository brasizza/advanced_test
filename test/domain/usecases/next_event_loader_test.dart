import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class NextEventLoader {
  final LoadNextEventRepository _repository;
  NextEventLoader({required LoadNextEventRepository repository}) : _repository = repository;
  Future<void> call({required String groupId}) async {
    await _repository.loadNextEvent(groupId: groupId);
  }
}

abstract interface class LoadNextEventRepository {
  Future<void> loadNextEvent({required String groupId});
}

class LoadNextMockCacheRepository implements LoadNextEventRepository {
  var callsCount = 0;
  String? groupId;
  @override
  Future<void> loadNextEvent({required String groupId}) async {
    callsCount++;
    this.groupId = groupId;
  }
}

void main() async {
  late String groupId;
  late LoadNextMockCacheRepository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = Random().nextInt(9999).toString();
    repo = LoadNextMockCacheRepository();
    sut = NextEventLoader(repository: repo);
  });
  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
}
