import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'http/services.dart';
import 'models/poi_model.dart';

export 'http/services.dart';
export 'models/poi_model.dart';

class TestPlugin extends StatefulWidget {
  const TestPlugin({Key? key}) : super(key: key);

  @override
  State<TestPlugin> createState() => _TestPluginState();
}

class _TestPluginState extends State<TestPlugin> {
  var styleString =
      'mapbox://styles/merrillgonsalves/cl5ez27io005p14rz5aqp8234';
  late MapboxMapController controller;
  var MAPBOX_ACCESS_TOKEN =
      "sk.eyJ1IjoibWVycmlsbGdvbnNhbHZlcyIsImEiOiJja2l6eno3ZWk0ZnYxMnNsYng5azdxdjBiIn0.fkx2_7LZ7uq80mHYCuh46w";
  late CameraPosition _initialCameraPosition;
  bool isLoading = true;
  GetPoi? poiPoints;
  List<LatLng> poisList = [];
  List<String> poisSubCat = [];
  LatLng? currentLocationIA;
  bool t1 = false;
  int? loopCounter;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    //LatLng(19.093099, 72.856952)
    _initialCameraPosition = const CameraPosition(
        target: LatLng(19.093099, 72.856952), zoom: 17, tilt: 30.0);
    fetchPois();
  }

  void _onMapCreated(MapboxMapController mapboxMapController) {
    controller = mapboxMapController;
  }

  fetchPois() async {
    poiPoints = await InternetService().getPOI().then((value) {
      loopCounter = value!.data!.length;
      poisList.clear();
      poisSubCat.clear();
      for (int a = 1; a <= loopCounter!; a++) {
        // print("latlng ${a - 1} is : ${value.data![a - 1].lat}");
        poisList.insert(
            a - 1, LatLng(value.data![a - 1].lat!, value.data![a - 1].lng!));

        poisSubCat.insert(
            a - 1, value.data?[a - 1].poiMultilingual!.en!.name ?? "Test");
      }
      return null;
    });
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    tappedaFunction(Symbol symbol) {
      print("print $symbol");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Tapped on POI")));
    }

    void addSymbol(MapboxMapController mapBoxController) {
      for (int a = 0; a < loopCounter!; a++) {
        mapBoxController.addSymbol(
          SymbolOptions(
              geometry: poisList[a],
              iconImage: "assets/symbols/neww.png",
              iconSize: 0.5,
              textField: poisSubCat[a],
              textSize: 15,
              iconOffset: const Offset(0, -50)),
        );
      }
      mapBoxController.onSymbolTapped.add(tappedaFunction);

      //SHOWING CURRENT USER LOCATION ON MAP
      mapBoxController.addSymbol(
        const SymbolOptions(
          geometry: LatLng(19.093099, 72.856952),
          // geometry: convertToLatLng(),
          iconImage: "assets/symbols/Oval.png",
          iconSize: 3,
        ),
      );
      mapBoxController.onSymbolTapped.add(tappedaFunction);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // child: Image.asset("assets/symbols/newMarker.png"),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Loading POI's & IA Location")
                ],
              ),
            )
          : SizedBox(
              width: width,
              height: height,
              child: MapboxMap(
                tiltGesturesEnabled: true,
                accessToken: MAPBOX_ACCESS_TOKEN,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                trackCameraPosition: true,
                onCameraTrackingChanged: (mode) {
                  // print("mode.name ${mode}");
                  // print("mode.name ${mode.name}");
                },
                onStyleLoadedCallback: () => addSymbol(controller),
                // myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                // minMaxZoomPreference:
                //     const MinMaxZoomPreference(14, 17),
                annotationOrder: const [AnnotationType.symbol],
                styleString: styleString,
              ),
            ),
    );
  }
}
