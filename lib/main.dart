
import 'dart:async';



import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import "package:google_maps_webservice/geocoding.dart";


import 'package:google_maps_webservice/places.dart';


void main() => runApp(MyApp());



class MyApp extends StatefulWidget {

  @override

  _MyAppState createState() => _MyAppState();

}



class _MyAppState extends State<MyApp> {

  Completer<GoogleMapController> _controller = Completer();


  static const kGoogleApiKey = "AIzaSyC_2vdelF5OBkFaphMp265a44jVwcF_eYI";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


  static const LatLng _center = const LatLng(24.7732, 67.0762);



  final Set<Marker> _markers = {};




   static  LatLng _lastMapPosition = _center;



  MapType _currentMapType = MapType.normal;


  List<PlacesSearchResult> places = [];

  void _onMapTypeButtonPressed() {

    setState(() {

      _currentMapType = _currentMapType == MapType.normal

          ? MapType.satellite

          : MapType.normal;

    });

  }





  void _onAddMarkerButtonPressed() async {
    var location = Location(  _center.latitude,_center.longitude);

    final result = await _places.searchByText("Masjid",location: location, radius: 1000,type: "Masjid");
    setState(() {
      result.results.forEach((f) {

            this.places = result.results;

            LatLng newloc= LatLng(f.geometry.location.lat, f.geometry.location.lng);
            print(f.name);


          _lastMapPosition=newloc;
            print(f.geometry.location.lat.toString() + f.geometry.location.lng.toString());
          _markers.add(Marker(


            // This marker id can be anything that uniquely identifies each marker.

            markerId: MarkerId(_lastMapPosition.toString()),

            position:  _lastMapPosition,

            infoWindow: InfoWindow(

              title: f.name,

              snippet:f.formattedAddress,



            ),

            icon: BitmapDescriptor.defaultMarker,
          ));
        });

    });
  }



      void _onCameraMove(CameraPosition position) {
        _lastMapPosition = position.target;
      }


      void _onMapCreated(GoogleMapController controller) {
        _controller.complete(controller);
      }



      @override
      Widget build(BuildContext context) {
        return MaterialApp(

          home: Scaffold(

            appBar: AppBar(

              title: Text('Maps Sample App'),

              backgroundColor: Colors.green[700],

            ),

            body: Stack(

              children: <Widget>[

                GoogleMap(

                  onMapCreated: _onMapCreated,

                  initialCameraPosition: CameraPosition(

                    target: _center,

                    zoom: 17.0,

                  ),

                  mapType: _currentMapType,

                  markers: _markers,

                  onCameraMove: _onCameraMove,

                ),

                Padding(

                  padding: const EdgeInsets.all(16.0),

                  child: Align(

                    alignment: Alignment.topRight,

                    child: Column(



                      children: <Widget>[

                         FloatingActionButton(

                          onPressed: _onMapTypeButtonPressed,

                          materialTapTargetSize: MaterialTapTargetSize.padded,

                          backgroundColor: Colors.green,

                          child: const Icon(Icons.map, size: 36.0),


                        ),

                        SizedBox(height: 16.0),

                        FloatingActionButton(

                          onPressed: _onAddMarkerButtonPressed,

                          materialTapTargetSize: MaterialTapTargetSize.padded,

                          backgroundColor: Colors.green,

                          child: const Icon(Icons.add_location, size: 36.0),

                        ),

                         SizedBox(height: 16.0),

                         FloatingActionButton(


                           materialTapTargetSize: MaterialTapTargetSize.padded,

                           backgroundColor: Colors.green,

                           child: const Icon(Icons.near_me, size: 36.0),


                         ),


                      ],

                    ),

                  ),

                ),

              ],

            ),

          ),

        );

      }

    }