import 'package:flutter/material.dart';
import 'package:fulleconomymileagetracker/Services/FirebaseServices.dart';

class OutputScreen extends StatefulWidget {
  final double startingKm;
  final double endingKm;
  final String vehicleType;
  final String fuelFilled;
  final String fuelPrice;

  const OutputScreen({
    super.key,
    required this.startingKm,
    required this.endingKm,
    required this.vehicleType,
    required this.fuelFilled,
    required this.fuelPrice,
  });

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  late final double distanceTravelled;
  late final double mileage;
  late final double totalFuelCost;
  late final double fuelPricePerLiter;
  late final double fuelEconomy;

  @override
  void initState() {
    super.initState();
    distanceTravelled = widget.endingKm - widget.startingKm;
    
    final filled = double.tryParse(widget.fuelFilled) ?? 0;
    final price = double.tryParse(widget.fuelPrice) ?? 0;
    mileage = filled > 0 ? distanceTravelled / filled : 0;
    totalFuelCost = price * filled;
    fuelPricePerLiter = price;
    fuelEconomy=totalFuelCost/distanceTravelled;
  }

  _saveData() async{

  print("@@@@saving data to Firebase");
  var firebaseServices =  Firebaseservices();
  final success= await firebaseServices.updateDataToFirebase(
    widget.startingKm,
    widget.endingKm,
    widget.vehicleType,
    widget.fuelFilled,
    widget.fuelPrice,
    distanceTravelled,
    mileage,
    totalFuelCost,
    fuelEconomy
  );
  if(success) {
    print("@@@@Data saved successfully to Firebase");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data saved successfully!"))
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to save data!"))
    );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trip Summary"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Display
              Row(
                children: [
                  Icon(
                    _getVehicleIcon(),
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Vehicle: ${widget.vehicleType.toUpperCase()}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  ElevatedButton(onPressed: _saveData, child: Text("Save"))
                ],
              ),
              const SizedBox(height: 20),
        
              // Trip Details Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow("Starting KM:", widget.startingKm.toStringAsFixed(1)),
                      _buildDetailRow("Ending KM:", widget.endingKm.toStringAsFixed(1)),
                      _buildDetailRow("Fuel Filled:", "${widget.fuelFilled} L"),
                      _buildDetailRow("Fuel Price:", "₹${widget.fuelPrice}/L"),
                      const Divider(),
                      _buildDetailRow(
                        "Distance Traveled:", 
                        "${distanceTravelled.toStringAsFixed(1)} km",
                        isBold: true,
                      ),
                      _buildDetailRow(
                        "Mileage:", 
                        "${mileage.toStringAsFixed(2)} km/L",
                        isBold: true,
                        valueColor: Colors.green,
                      ),
                      _buildDetailRow(
                        "Total Fuel Cost:", 
                        "₹${totalFuelCost.toStringAsFixed(2)}",
                        isBold: true,
                        valueColor: Colors.red,
                      ),
                      _buildDetailRow(
                        "Fuel Economy:", 
                        "₹${fuelEconomy.toStringAsFixed(2)}",
                        isBold: true,
                        valueColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
        
              // Fuel Efficiency Tips
              if (mileage > 0) ...[
                const SizedBox(height: 20),
                const Text(
                  "Fuel Efficiency Tips:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  _getEfficiencyTip(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getVehicleIcon() {
    switch (widget.vehicleType.toLowerCase()) {
      case 'car': return Icons.directions_car;
      case 'bike': return Icons.pedal_bike;
      case 'bus': return Icons.directions_bus;
      default: return Icons.directions_car;
    }
  }

  String _getEfficiencyTip() {
    if (mileage < 10) return "Consider vehicle maintenance for better mileage";
    if (mileage < 15) return "Good efficiency, but could be improved";
    return "Excellent fuel efficiency!";
  }
}