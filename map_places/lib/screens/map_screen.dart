import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initPlaceLocation;
  final bool isSelecting;

  MapScreen(this.initPlaceLocation, {this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Map'), actions: [
        IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // below is dump latlng, future use listener from maps to get actual location
              const latLng = LatLng(-7.6927943, 112.8939646);
              Navigator.of(context).pop(latLng);
            })
      ]),
      body: GoogleMap(
        // TODO: implement map click listener gk punya API :(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initPlaceLocation.latitude,
                widget.initPlaceLocation.longitude),
            zoom: 16),
      ),
    );
  }
}
