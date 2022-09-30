import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class TestMapPlugin extends StatefulWidget {
  const TestMapPlugin({Key? key}) : super(key: key);

  @override
  State<TestMapPlugin> createState() => _TestMapPluginState();
}

class _TestMapPluginState extends State<TestMapPlugin> {

  static const String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN");

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      child: MapboxMap(initialCameraPosition: CameraPosition(
        target: LatLng(-33.852, 151.211),
        zoom: 11.0,
      )),
    );
  }
}
