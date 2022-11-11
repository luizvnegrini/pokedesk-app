import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core.dart';

class RemoteDataSourceAdapter implements IRemoteDataSourceAdapter {
  final String baseUrl;
  String get apiVersion => '/api/v2';

  RemoteDataSourceAdapter({
    required this.baseUrl,
  });

  @override
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await http.get(
      Uri.https(
        baseUrl,
        '$apiVersion$endpoint',
        queryParams,
      ),
    );

    return jsonDecode(response.body);
  }
}
