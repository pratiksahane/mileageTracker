import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firebaseservices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> updateDataToFirebase(startingKm, endingKm, vehicleType, fuelFilled, fuelPrice, distanceTravelled, mileage, totalFuelCost, fuelEconomy) async {
    try {
      await _firestore.collection('mileage_data').add({
        'starting_km': startingKm,
        'ending_km': endingKm,
        'vehicle_type': vehicleType,
        'fuel_filled': fuelFilled,
        'fuel_price': fuelPrice,
        'distance_travelled': distanceTravelled,
        'mileage': mileage,
        'total_fuel_cost': totalFuelCost,
        'fuel_economy': fuelEconomy,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print("@@@Error updating data to Firebase: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('mileage_data').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("@@@Error fetching data from Firebase: $e");
      return [];
    }
  }
}