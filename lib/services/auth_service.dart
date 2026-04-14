import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/network/dio_client.dart';

class AuthService {
  static String? lastError;

  final Dio _dio = DioClient.dio;

  Future<bool> login(String username, String password) async {
    try {
      final requestPath = 'token/';
      final finalUrl = '${_dio.options.baseUrl}$requestPath';
      print('AuthService: POST -> $finalUrl');
      final response = await _dio.post(
        requestPath,
        data: {
          "username": username,
          "password": password,
        },
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", response.data["access"]);

      lastError = null;
      return true;
    } on DioException catch (e) {
      final errorBody = e.response?.data;
      final message = (errorBody is Map)
          ? (errorBody['detail'] ?? errorBody.toString())
          : (errorBody?.toString() ?? e.message);
      lastError = 'DioException: $message (status: ${e.response?.statusCode}) -> URL: ${_dio.options.baseUrl}token/';
      print(lastError);
      return false;
    } catch (e) {
      lastError = e.toString();
      print('AuthService login error: $e -> URL: ${_dio.options.baseUrl}token/');
      return false;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}