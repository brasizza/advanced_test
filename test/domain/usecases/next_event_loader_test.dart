import 'package:advanced_test/domain/entities/next_event.dart';
import 'package:advanced_test/domain/entities/next_player_event.dart';
import 'package:advanced_test/domain/repositories/load_next_event_repository.dart';
import 'package:advanced_test/domain/usecases/next_event_loader.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

class LoadNextSpyCacheRepository implements LoadNextEventRepository {
  var callsCount = 0;
  NextEvent? output;

  String? groupId;

  Error? error;
  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    callsCount++;

    if (error != null) throw error!;
    this.groupId = groupId;
    return output!;
  }
}

void main() async {
  late String groupId;
  late LoadNextSpyCacheRepository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = Fakes.anyString();
    repo = LoadNextSpyCacheRepository();
    sut = NextEventLoader(repository: repo);

    repo.output = NextEvent(
      groupName: 'any group name',
      date: DateTime.now(),
      players: [
        NexEventPlayer(id: 'any id 1', name: 'name 1', isConfirmed: true, photo: '', confirmationData: DateTime.now()),
        NexEventPlayer(id: 'any id 2', name: 'name 2', isConfirmed: false, position: 'any position', confirmationData: DateTime.now()),
      ],
    );
  });
  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
  test('should return event data on success', () async {
    final event = await sut(groupId: groupId);
    expect(event.groupName, repo.output?.groupName);
    expect(event.date, repo.output?.date);
    expect(event.players.length, 2);
    expect(event.players[0].id, repo.output?.players[0].id);
    expect(event.players[0].initials, isNotEmpty);
    expect(event.players[0].name, repo.output?.players[0].name);
    expect(event.players[0].photo, repo.output?.players[0].photo);
    expect(event.players[0].isConfirmed, repo.output?.players[0].isConfirmed);
    expect(event.players[0].confirmationData, repo.output?.players[0].confirmationData);

    expect(event.players[1].id, repo.output?.players[1].id);
    expect(event.players[1].initials, isNotEmpty);
    expect(event.players[1].name, repo.output?.players[1].name);
    expect(event.players[1].position, repo.output?.players[1].position);
    expect(event.players[1].isConfirmed, repo.output?.players[1].isConfirmed);
    expect(event.players[1].confirmationData, repo.output?.players[1].confirmationData);
  });

  test('should  rethow on error', () async {
    final error = Error();
    repo.error = error;
    final future = sut(groupId: groupId);
    expect(future, throwsA(error));
  });
}
