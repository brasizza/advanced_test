import 'dart:convert';
import 'dart:typed_data';

import 'package:advanced_test/domain/entities/next_event.dart';
import 'package:advanced_test/domain/entities/next_player_event.dart';
import 'package:advanced_test/domain/repositories/load_next_event_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../../helpers/fakes.dart';

enum DomainError {
  unexpectedError;
}

class LoadNextEventHttpRepository implements LoadNextEventRepository {
  final Client httpClient;
  final String url;
  LoadNextEventHttpRepository({required this.httpClient, required this.url});
  @override
  Future<NextEvent> loadNextEvent({required groupId}) async {
    final response = await httpClient.get(
        Uri.parse(
          url.replaceAll(':groupId', groupId),
        ),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        });

    if (response.statusCode != 200) {
      throw DomainError.unexpectedError;
    }

    final event = json.decode(response.body);

    return NextEvent(
      groupName: event['groupName'],
      date: DateTime.parse(event['date']),
      players: event['players']
          .map<NexEventPlayer>(
            (player) => NexEventPlayer(
              id: player['id'],
              name: player['name'],
              isConfirmed: player['isConfirmed'],
              confirmationData: DateTime.tryParse(player['confirmationDate'] ?? ''),
              position: player['position'],
              photo: player['photo'],
            ),
          )
          .toList(),
    );
  }
}

void main() {
  late String groupId;
  late String url;
  late HttpClientSpy httpClient;
  late LoadNextEventHttpRepository sut;

  setUpAll(() {
    url = 'https://domain.com.br/api/groups/:groupId/next_event';
  });

  setUp(() {
    httpClient = HttpClientSpy();
    groupId = Fakes.anyString();
    httpClient.responseJson = '''
  {
  "groupName": "any name",
  "date": "2025-03-03T10:40",
  "players": [
    {
      "id": "id 1",
      "name": "name 1",
      "isConfirmed": true
    },
    {
      "id": "name 2",
      "name": "name 2", 
      "position": "name 2",
      "photo": "name 2",
      "confirmationDate": "2025-03-02T10:40",
      "isConfirmed": false
    }
  ]
}
''';
    sut = LoadNextEventHttpRepository(httpClient: httpClient, url: url);
  });
  test('should request with correct method', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.method, 'get');
    expect(httpClient.callsCount, 1);
  });

  test('should request with correct url', () async {
    const url = 'https://domain.com.br/api/groups/:groupId/next_event';
    final sut = LoadNextEventHttpRepository(httpClient: httpClient, url: url);
    var groupId = Fakes.anyString();
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.url, 'https://domain.com.br/api/groups/$groupId/next_event');
  });

  test('should request with correct headers', () async {
    var groupId = Fakes.anyString();
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.headers?['content-type'], 'application/json');
    expect(httpClient.headers?['accept'], 'application/json');
  });

  test('should return NextEvent on 200 ', () async {
    var groupId = Fakes.anyString();
    final event = await sut.loadNextEvent(groupId: groupId);
    expect(event.groupName, 'any name');
    expect(event.date, DateTime(2025, 3, 3, 10, 40));
    expect(event.players[0].id, 'id 1');
    expect(event.players[0].name, 'name 1');
    expect(event.players[0].isConfirmed, true);

    expect(event.players[1].id, 'name 2');
    expect(event.players[1].name, 'name 2');
    expect(event.players[1].position, 'name 2');
    expect(event.players[1].photo, 'name 2');
    expect(event.players[1].confirmationData, DateTime(2025, 3, 2, 10, 40));
    expect(event.players[1].isConfirmed, false);
  });

  test('should throw unexpectedError on 400 ', () async {
    httpClient.statusCode = 400;
    var groupId = Fakes.anyString();
    final future = sut.loadNextEvent(groupId: groupId);
    expect(future, throwsA(DomainError.unexpectedError));
  });
}

class HttpClientSpy implements Client {
  String? method;
  int callsCount = 0;
  String? url = '';

  Map<String, String>? headers;

  String responseJson = '';
  int statusCode = 200;
  @override
  void close() {}

  @override
  Future<Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    method = 'get';
    callsCount++;
    this.headers = headers;
    this.url = url.toString();
    return Response(responseJson, statusCode);
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    throw UnimplementedError();
  }
}
