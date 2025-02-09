import 'package:advanced_test/domain/entities/next_player_event.dart';

class NextEvent {
  final String groupName;
  final DateTime date;
  final List<NexEventPlayer> players;
  NextEvent({
    required this.groupName,
    required this.date,
    required this.players,
  });
}
