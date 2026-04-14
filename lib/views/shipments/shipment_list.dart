import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/shipment_provider.dart';

class ShipmentListScreen extends ConsumerWidget {
  const ShipmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final shipmentsAsync = ref.watch(shipmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Shipments"),
      ),

      body: shipmentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (err, stack) => Center(
          child: Text("Error: $err"),
        ),

        data: (shipments) {
          if (shipments.isEmpty) {
            return const Center(
              child: Text("No shipments found"),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Invalidate the provider so it reloads, then await its future
              ref.invalidate(shipmentListProvider);
              try {
                await ref.read(shipmentListProvider.future);
              } catch (_) {
                // ignore errors during manual refresh; the UI shows errors via the provider
              }
            },
            child: ListView.builder(
              itemCount: shipments.length,
              itemBuilder: (context, index) {

                final shipment = shipments[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.local_shipping),

                    title: Text(shipment.receiverName),

                    subtitle: Text(
                      "${shipment.pickupLocation} → ${shipment.deliveryLocation}",
                    ),

                    trailing: Chip(
                      label: Text(shipment.status),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ShipmentList extends StatelessWidget {
  const ShipmentList({super.key});

  @override
  Widget build(BuildContext context) => const ShipmentListScreen();
}