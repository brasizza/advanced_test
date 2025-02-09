import '../entities/next_event.dart';
import '../repositories/load_next_event_repository.dart';

class NextEventLoader {
  final LoadNextEventRepository _repository;
  NextEventLoader({
    required LoadNextEventRepository repository,
  }) : _repository = repository;

  Future<NextEvent> call({required String groupId}) async {
    return await _repository.loadNextEvent(groupId: groupId);
  }
}
