import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class CreateShipmentScreen extends StatefulWidget {
  const CreateShipmentScreen({super.key});

  @override
  State<CreateShipmentScreen> createState() => _CreateShipmentScreenState();
}

class _CreateShipmentScreenState extends State<CreateShipmentScreen> {

  final ApiService api = ApiService();

  final senderController = TextEditingController();
  final receiverController = TextEditingController();
  final pickupController = TextEditingController();
  final deliveryController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Shipment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            TextField(
              controller: senderController,
              decoration: const InputDecoration(
                labelText: "Sender Name",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: receiverController,
              decoration: const InputDecoration(
                labelText: "Receiver Name",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: pickupController,
              decoration: const InputDecoration(
                labelText: "Pickup Location",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: deliveryController,
              decoration: const InputDecoration(
                labelText: "Delivery Location",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

           ElevatedButton(
              onPressed: () async {

                print("Create button pressed");

                 final data = {
                    "sender_name": senderController.text,
                    "receiver_name": receiverController.text,
                    "pickup_location": pickupController.text,
                    "delivery_location": deliveryController.text,
                    "weight": int.parse(weightController.text),
                  };

                   print("Sending data: $data");

                   final result = await api.createShipment(data);

                   print("API result: $result");

                if (result['success']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Shipment Created Successfully")),
                );
                  // Clear form
                  senderController.clear();
                  receiverController.clear();
                  pickupController.clear();
                  deliveryController.clear();
                  weightController.clear();
               } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result['message'] ?? "Failed to create shipment")),
            );
              }
            },
              child: const Text("Create Shipment"),
            ),
          ],
        ),  
      ),
    );
  }
}  
  