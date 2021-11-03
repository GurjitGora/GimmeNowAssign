import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("MapBox"),
            IconButton(
              onPressed: () async {
                try {
                  await Amplify.Auth.signOut();
                } on AuthException catch (e) {
                  print(e.message);
                }
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('/LandingPage'));
              },
              icon: Icon(Icons.exit_to_app_rounded),
            ),
          ],
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/gurjitgora/ckvjk9n4ugujc14mv8vj6j4c5/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ3Vyaml0Z29yYSIsImEiOiJja3ZqaWhpNTljdXkyMnptbm5nNGxhc2V1In0.UhdCONXcToFPHGzAGhwlmA",
              additionalOptions: {
                'accesstoken':
                    'pk.eyJ1IjoiZ3Vyaml0Z29yYSIsImEiOiJja3ZqaWhpNTljdXkyMnptbm5nNGxhc2V1In0.UhdCONXcToFPHGzAGhwlmA',
                'id': 'mapbox.mapbox-streets-v8'
              }),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
