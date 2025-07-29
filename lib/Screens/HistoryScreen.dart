import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fulleconomymileagetracker/Screens/HomeScreen.dart'; 
import 'package:fulleconomymileagetracker/Services/FirebaseServices.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<List<Map<String, dynamic>>> _historyData;

  IconData getIcon(String vehicleType) {
  switch (vehicleType.toLowerCase()) {
    case 'car':
      return Icons.directions_car;
    case 'bike':
      return Icons.motorcycle;
    case 'bus':
      return Icons.directions_bus;
    default:
      return Icons.directions;
  }
}

  String _formatTimestamp(dynamic timestamp) {
  if (timestamp == null) return 'No date';
  
  try {
    // Handle Firestore Timestamp
    if (timestamp is Timestamp) {
      return DateFormat('MMM dd, yyyy - hh:mm a').format(timestamp.toDate());
    }
    // Handle DateTime directly
    else if (timestamp is DateTime) {
      return DateFormat('MMM dd, yyyy - hh:mm a').format(timestamp);
    }
    // Handle string timestamps
    else if (timestamp is String) {
      final parsedDate = DateTime.tryParse(timestamp);
      if (parsedDate != null) {
        return DateFormat('MMM dd, yyyy - hh:mm a').format(parsedDate);
      }
    }
    return 'Invalid date';
  } catch (e) {
    return 'Date unavailable';
  }
}
  @override
  void initState() {
    super.initState();
    _historyData = _getHistoryData();
    print("@@@@@$_historyData");
  }
  
  Future<List<Map<String, dynamic>>> _getHistoryData() async {
    final firebaseServices = Firebaseservices();
    return await firebaseServices.getDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Homescreen())),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _historyData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No history data available'));
          }

          final historyItems = snapshot.data!;

          return Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                final item = historyItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(getIcon(item['vehicle_type']), size: 32, color: Colors.blue),
                            Text(
                              item['vehicle_type'].toString().toUpperCase() ?? 'No title',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "${item['starting_km'].toString()} kms" ?? 'Not specified',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            Icon(Icons.arrow_forward, color: Colors.blue),
                            Text(
                              "${item['ending_km'].toString()} kms" ?? 'Not specified',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.currency_rupee_outlined),
                            Text(
                              item['total_fuel_cost'].toString() ?? 'No description',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            
                            ),
                          ],
                        ),
                        if (item['mileage'] != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            'Mileage: ${item['mileage']} km',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                          'Date: ${_formatTimestamp(item['timestamp'])}',
                          style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                          ),
                      ),  
                        ],
                      ],
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