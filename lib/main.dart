import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.attach_money),
          ),
          bottomNavigationBar: Container(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star_border,
                  size: 40,
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text('Anamaya'),
            backgroundColor: Colors.green[700],
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0),
              zoom: 2,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
      );
}
