import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TestMapPlugin extends StatefulWidget {
  const TestMapPlugin({Key? key}) : super(key: key);

  @override
  State<TestMapPlugin> createState() => _TestMapPluginState();
}

class _TestMapPluginState extends State<TestMapPlugin> {

  var styleString =
      'mapbox://styles/merrillgonsalves/cl5ez27io005p14rz5aqp8234';
  late MapboxMapController controller;
  var MAPBOX_ACCESS_TOKEN="sk.eyJ1IjoibWVycmlsbGdvbnNhbHZlcyIsImEiOiJja2l6eno3ZWk0ZnYxMnNsYng5azdxdjBiIn0.fkx2_7LZ7uq80mHYCuh46w";

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      child: MapboxMap(
          initialCameraPosition: CameraPosition(
        target: LatLng(-33.852, 151.211),
        zoom: 11.0,
      ),
        tiltGesturesEnabled: true,
        // accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
        accessToken: MAPBOX_ACCESS_TOKEN,
        onMapCreated: (MapboxMapController controller){},
        trackCameraPosition: true,
        onCameraTrackingChanged: (mode) {
          // print("mode.name ${mode}");
          // print("mode.name ${mode.name}");
        },

        onStyleLoadedCallback: (){},
        // onStyleLoadedCallback: () => addSymbol(controller),
        // myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
        // minMaxZoomPreference:
        //     const MinMaxZoomPreference(14, 17),
        annotationOrder: [AnnotationType.symbol],
        styleString: styleString,
      ),
    );
  }
}
