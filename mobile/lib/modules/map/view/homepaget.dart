import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (ccontext) {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.red,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(20, 20),
          zoom: 16,
        ),
        onMapCreated: (gController) {
          controller = gController;
        },
        myLocationButtonEnabled: false,
        markers: {
          Marker(
            markerId: const MarkerId('value'),
            position: const LatLng(20, 20),
            onTap: () async {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => TestPage()));
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (ccontext) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.red,
                  );
                },
              );
            },
          ),
        },
      ),
    );
  }
}
