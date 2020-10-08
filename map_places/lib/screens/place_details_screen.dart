import 'package:flutter/material.dart';
import 'package:map_places/providers/great_places.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class PlacesDetailScreen extends StatelessWidget {
  static const routeName = '/places-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 250,
              child: Image.file(
                selectedPlace.image,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              // TODO: use map screen to navigate this function so it can be still show maps on the current Apps
              MapsLauncher.launchCoordinates(selectedPlace.location.latitude,
                  selectedPlace.location.longitude);
            },
          )
        ],
      ),
    );
  }
}
