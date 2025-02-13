import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../../helpers/fakes.dart';

class LoadNextEventHttpRepository {
  final Client httpClient;
  final String url;
  LoadNextEventHttpRepository({required this.httpClient, required this.url});
  loadNextEvent({required groupId}) async {
    await httpClient.get(
        Uri.parse(
          url.replaceAll(':groupId', groupId),
        ),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        });
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
    sut = LoadNextEventHttpRepository(httpClient: httpClient, url: url);
  });
  test('sould request with correct method', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.method, 'get');
    expect(httpClient.callsCount, 1);
  });

  test('sould request with correct url', () async {
    final httpClient = HttpClientSpy();
    const url = 'https://domain.com.br/api/groups/:groupId/next_event';
    final sut = LoadNextEventHttpRepository(httpClient: httpClient, url: url);
    var groupId = Fakes.anyString();
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.url, 'https://domain.com.br/api/groups/$groupId/next_event');
  });

  test('sould request with correct headers', () async {
    final httpClient = HttpClientSpy();
    const url = 'https://domain.com.br/api/groups/:groupId/next_event';
    final sut = LoadNextEventHttpRepository(httpClient: httpClient, url: url);
    var groupId = Fakes.anyString();
    await sut.loadNextEvent(groupId: groupId);
    expect(httpClient.headers?['content-type'], 'application/json');
    expect(httpClient.headers?['accept'], 'application/json');
  });
}

class HttpClientSpy implements Client {
  String? method;
  int callsCount = 0;
  String? url = '';

  Map<String, String>? headers;
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
    return Response('', 200);
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
