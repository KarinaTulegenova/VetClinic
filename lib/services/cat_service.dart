import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cat_model.dart';

class CatService {
  const CatService({http.Client? client}) : _client = client;

  static final Uri _endpoint = Uri.parse(
    'https://api.thecatapi.com/v1/images/search?limit=10',
  );

  final http.Client? _client;

  Future<List<Cat>> fetchCats() async {
    final client = _client ?? http.Client();
    try {
      final response = await client.get(_endpoint);
      if (response.statusCode != 200) {
        throw CatServiceException('Cat API returned ${response.statusCode}.');
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const CatServiceException('Cat API response is not a list.');
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(Cat.fromJson)
          .where((cat) => cat.id.isNotEmpty && cat.imageUrl.isNotEmpty)
          .toList(growable: false);
    } on CatServiceException {
      rethrow;
    } catch (_) {
      throw const CatServiceException('Unable to load cats right now.');
    } finally {
      if (_client == null) {
        client.close();
      }
    }
  }
}

class CatServiceException implements Exception {
  const CatServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}
