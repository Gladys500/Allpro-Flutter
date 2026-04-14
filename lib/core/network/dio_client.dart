import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:allpro_logistics/services/auth_service.dart';

class DioClient {
  static String _determineBaseUrl() {
    // On web use the current origin so we avoid mixed-content issues
    if (kIsWeb) {
      // When running as web, point directly to the backend to avoid
      // hitting the Flutter dev server origin which doesn't host the API.
      // Ensure CORS is enabled on the backend.
      return 'http://192.168.1.74:8000/api/';
    }

    // Fallback / mobile/dev machine address
    // Use your local backend IP/port. Change if your backend runs elsewhere.
    return 'http://192.168.1.74:8000/api/';
  }

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: _determineBaseUrl(),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )
    ..interceptors.addAll([
      InterceptorsWrapper(onRequest: (options, handler) async {
        try {
          final token = await AuthService().getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          // ignore errors retrieving token; continue without auth header
        }
        handler.next(options);
      }),
      LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
    ]);
}