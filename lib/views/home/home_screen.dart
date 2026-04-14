import 'package:flutter/material.dart';
import '../shipments/create_shipment.dart';
import '../shipments/shipment_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AllPro Logistics Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            dashboardCard(
              icon: Icons.inventory,
              title: "Total Shipments",
              color: const Color.fromARGB(255, 9, 97, 168),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ShipmentListScreen(),
                  ),
                );
              },
            ),
            dashboardCard(
              icon: Icons.local_shipping,
              title: "Active Deliveries",
              color: Colors.green,
              onTap: () {},
            ),
            dashboardCard(
              icon: Icons.location_on,
              title: "Track Shipment",
              color: Colors.orange,
              onTap: () {},
            ),
            dashboardCard(
              icon: Icons.add_box,
              title: "Create Shipment",
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateShipmentScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}