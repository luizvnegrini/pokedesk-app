abstract class IRemoteDataSourceAdapter {
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  });
}
