import 'package:flutter/material.dart';
import '../../models/shipment.dart';
import '../../services/api_service.dart';

class ShipmentDetails extends StatefulWidget {
  final Shipment shipment;

  const ShipmentDetails({super.key, required this.shipment});

  @override
  State<ShipmentDetails> createState() => _ShipmentDetailsState();
}

class _ShipmentDetailsState extends State<ShipmentDetails> {

  final ApiService api = ApiService();

  String status = "";

  @override
  void initState() {
    super.initState();
    status = widget.shipment.status;
  }

  void updateStatus() async {
    bool success = await api.updateShipmentStatus(
      widget.shipment.id,
      status,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Status updated")),
      );
    }
  }

  void deleteShipment() async {
    bool success = await api.deleteShipment(widget.shipment.id);

    if (success) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Shipment deleted")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final shipment = widget.shipment;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipment Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Sender: ${shipment.senderName}",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text("Receiver: ${shipment.receiverName}",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text("Pickup: ${shipment.pickupLocation}",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text("Delivery: ${shipment.deliveryLocation}",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text("Weight: ${shipment.weight} kg",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            DropdownButton<String>(
              value: status,
              items: const [
                DropdownMenuItem(value: "pending", child: Text("Pending")),
                DropdownMenuItem(value: "in_transit", child: Text("In Transit")),
                DropdownMenuItem(value: "delivered", child: Text("Delivered")),
              ],
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateStatus,
              child: const Text("Update Status"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: deleteShipment,
              child: const Text("Delete Shipment"),
            )

          ],
        ),
      ),
    );
  }
}