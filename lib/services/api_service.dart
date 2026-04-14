import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../models/shipment.dart';
import 'auth_service.dart';

class ApiService {
  final Dio _dio = DioClient.dio;
  final AuthService _authService = AuthService();

  Future<List<Shipment>> getShipments() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        print('No valid token found');
        return [];
      }
      return [];
    } on DioException catch (e) {
      print('GET ERROR (DioException): ${e.message}');
      return [];
    } catch (e) {
      print('GET ERROR: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> createShipment(Map<String, dynamic> data) async {
    try {
      if (data['weight'] != null) {
        final w = data['weight'];
        if (w is num) {
          data['weight'] = w.toDouble();
        } else if (w is String) {
          final parsed = double.tryParse(w.trim());
          if (parsed == null) {
            return {
              'success': false,
              'message': 'Invalid weight value: "$w"',
              'data': null,
            };
          }
          data['weight'] = parsed;
        } else {
          return {
            'success': false,
            'message': 'Unsupported weight type',
            'data': null,
          };
        }
      }

      final response = await _dio.post(
        'shipments/',
        data: data,
      );

      return {
        'success': response.statusCode == 201,
        'message': response.statusCode == 201
            ? 'Shipment created successfully'
            : 'Server responded with status ${response.statusCode}',
        'data': response.data,
      };
    } on DioException catch (e) {
      final errorBody = e.response?.data;
      final errorMessage = (errorBody is Map)
          ? (errorBody['detail'] ?? errorBody.toString())
          : (errorBody?.toString() ?? e.message);

      print('DioException: $errorMessage');
      print('Status code: ${e.response?.statusCode}');

      return {
        'success': false,
        'message': 'Error: $errorMessage',
        'data': null,
      };
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': 'Unexpected error: $e',
        'data': null,
      };
    }
  }

  Future<bool> updateShipmentStatus(int id, String status) async {
    try {
      final response = await _dio.patch(
        'shipments/$id/',
        data: {'status': status},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Update status error: $e');
      return false;
    }
  }

  Future<bool> deleteShipment(int id) async {
    try {
      final response = await _dio.delete('shipments/$id/');
      return response.statusCode == 204;
    } catch (e) {
      print('Delete error: $e');
      return false;
    }
  }
}