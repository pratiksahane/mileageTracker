import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fulleconomymileagetracker/Screens/HistoryScreen.dart';
import 'package:fulleconomymileagetracker/Screens/OutputScreen.dart';
import 'package:fulleconomymileagetracker/Screens/SettingsScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedVehicle = 'car'; 
  final TextEditingController vehicleType = TextEditingController();
  final TextEditingController startingKm=TextEditingController();
  final TextEditingController endingKm=TextEditingController();
  final TextEditingController fuelFilled=TextEditingController();
  final TextEditingController fuelPrice=TextEditingController();
  final List<DropdownMenuEntry<String>> vehicleItems = const [
    DropdownMenuEntry(
      value: 'car',
      label: 'Car',
      leadingIcon: Icon(Icons.directions_car),
    ),
    DropdownMenuEntry(
      value: 'bike',
      label: 'Bike',
      leadingIcon: Icon(Icons.pedal_bike),
    ),
    DropdownMenuEntry(
      value: 'bus',
      label: 'Bus',
      leadingIcon: Icon(Icons.directions_bus),
    ),
  ];

 void _exitApp() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Exit App"),
      content: const Text("Are you sure you want to exit?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(), 
          child: const Text("Exit" ,style: TextStyle(color: Colors.red),),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      appBar: AppBar(
        title: const Text("Home"),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: Drawer( 
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(child: Text('Menu', style: TextStyle(fontSize: 30, color: Theme.of(context).scaffoldBackgroundColor),)),
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>History()));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Settingsscreen()));
              },
            ),
            const SizedBox(height: 300,),
           ElevatedButton(
  onPressed: _exitApp,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    minimumSize: const Size(120, 50), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: const Text("Exit"),
)
          ],
        ),
      ),
      body:Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.speed_outlined, size: 40,),
                Text("Odometer", style: TextStyle(fontSize: 25),),
              ],
            ),
            const SizedBox(height: 50,),
            Container(
             height: MediaQuery.of(context).size.width * 0.98,
             width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                gradient:  LinearGradient(
        colors: [
          const Color.fromARGB(255, 252, 251, 252),
          const Color.fromARGB(255, 173, 214, 250),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
            ),borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                 Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownMenu<String>(
          controller: vehicleType,
          width: MediaQuery.of(context).size.width * 0.75,
          initialSelection: selectedVehicle,
          dropdownMenuEntries: vehicleItems,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          menuStyle: MenuStyle(
            elevation: MaterialStateProperty.all(4),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onSelected: (String? value) {
            setState(() {
              selectedVehicle = value!;
              vehicleType.text = vehicleItems.firstWhere(
                (e) => e.value == value).label;
            });
            print('Selected vehicle: $value');
          },
          leadingIcon: const Icon(Icons.directions_car), 
          label: const Text('Select Vehicle'),
        ),
            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: startingKm,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration:InputDecoration(
                            label: Text("Starting Km", style: TextStyle(color:Colors.black),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            )
                          )
                        )),
                        const SizedBox(width: 10,),
                        SizedBox(
                        height:MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: endingKm,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration:InputDecoration(
                            label: Text("Ending Km", style: TextStyle(color:Colors.black),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            )
                          )
                        )),
                    ],
                  ),
                  SizedBox(
                        height:MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: fuelFilled,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration:InputDecoration(
                            prefixIcon: Icon(Icons.local_gas_station),
                            label: Text("Fuel Filled(in litres)", style: TextStyle(color:Colors.black),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            )
                          )
                        )),
                        SizedBox(
                        height:MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: fuelPrice,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration:InputDecoration(
                            prefixIcon: Icon(Icons.currency_rupee_sharp),
                            label: Text("Fuel Price(in Rupees)", style: TextStyle(color:Colors.black),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)
                            )
                          )
                        )),
                        SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.75,
          child: ElevatedButton(
            onPressed: () {
        if(double.parse(startingKm.text)>=double.parse(endingKm.text)){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter valid starting & ending kms')));
        }else if(double.parse(fuelFilled.text)==0 || double.parse(fuelPrice.text)==0){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter valid fuelfilled and it\'s price ')));
        }
        else if (startingKm.text.isNotEmpty && 
            endingKm.text.isNotEmpty ) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OutputScreen(
                startingKm: double.parse(startingKm.text),
                endingKm: double.parse(endingKm.text),
                vehicleType: selectedVehicle.toString(),
                fuelFilled:fuelFilled.text,
                fuelPrice:fuelPrice.text
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter all details')));
        }
            },
            style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, 
        foregroundColor: Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
        ),
        elevation: 5, 
            ),
            child: const Text(
        "Calculate",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
            ),
          ),
        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}