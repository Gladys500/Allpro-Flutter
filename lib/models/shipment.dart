class Shipment {
  final int id;
  final String senderName;
  final String receiverName;
  final String pickupLocation;
  final String deliveryLocation;
  final int weight;
  final String status;

  Shipment({
    required this.id,
    required this.senderName,
    required this.receiverName,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.weight,
    required this.status,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'],
      senderName: json['sender_name'],
      receiverName: json['receiver_name'],
      pickupLocation: json['pickup_location'],
      deliveryLocation: json['delivery_location'],
      weight: json['weight'],
      status: json['status']  ?? "pending",
    );
  }
}