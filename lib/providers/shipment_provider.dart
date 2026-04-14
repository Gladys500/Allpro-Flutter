import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/shipment.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final shipmentListProvider = FutureProvider<List<Shipment>>((ref) async {
  final api = ApiService();
  return api.getShipments();
});