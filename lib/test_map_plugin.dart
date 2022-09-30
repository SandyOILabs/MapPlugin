import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'http/services.dart';
import 'models/poi_model.dart';

export 'http/services.dart';
export 'models/poi_model.dart';

class InsuideMap extends StatefulWidget {
  const InsuideMap({Key? key}) : super(key: key);

  @override
  State<InsuideMap> createState() => _InsuideMapState();
}

class _InsuideMapState extends State<InsuideMap> {
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

    // return Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {},
    //     // child: Image.asset("assets/symbols/newMarker.png"),
    //   ),
    //   body: isLoading
    //       ? Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: const [
    //               CircularProgressIndicator(),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Text("Loading POI's & IA Location")
    //             ],
    //           ),
    //         )
    //       : SizedBox(
    //           width: width,
    //           height: height,
    //           child: MapboxMap(
    //             tiltGesturesEnabled: true,
    //             accessToken: MAPBOX_ACCESS_TOKEN,
    //             initialCameraPosition: _initialCameraPosition,
    //             onMapCreated: _onMapCreated,
    //             trackCameraPosition: true,
    //             onCameraTrackingChanged: (mode) {
    //               // print("mode.name ${mode}");
    //               // print("mode.name ${mode.name}");
    //             },
    //             onStyleLoadedCallback: () => addSymbol(controller),
    //             // myLocationEnabled: true,
    //             myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
    //             // minMaxZoomPreference:
    //             //     const MinMaxZoomPreference(14, 17),
    //             annotationOrder: const [AnnotationType.symbol],
    //             styleString: styleString,
    //           ),
    //         ),
    // );

    double myHeight = MediaQuery.of(context).size.height / 3.8;
    double myBigHeight = MediaQuery.of(context).size.height - myHeight - 100;
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    double btnPadding = 10.0;
    double btnSize = 25.0;
    double fontSize = 16.0;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            SizedBox(
              child: isLoading
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
                  : Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              height: myBigHeight,
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

                                onStyleLoadedCallback: () =>
                                    addSymbol(controller),
                                // myLocationEnabled: true,
                                myLocationTrackingMode:
                                    MyLocationTrackingMode.TrackingGPS,
                                // minMaxZoomPreference:
                                //     const MinMaxZoomPreference(14, 17),
                                annotationOrder: const [AnnotationType.symbol],
                                styleString: styleString,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // controller.animateCamera(
                                      //     CameraUpdate.newCameraPosition(
                                      //         CameraPosition(
                                      //             target: convertToLatLng())));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(btnPadding),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.gps_fixed,
                                        size: btnSize,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(50),
                                                            topRight:
                                                                Radius.circular(
                                                                    50))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                              });
                                                              // customPOIbasedonLevelId(
                                                              //     0);
                                                              Navigator.pop(
                                                                  context);
                                                              // _body(t1l1);
                                                            },
                                                            child: const Text(
                                                                "Level 0")),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                              });
                                                              // customPOIbasedonLevelId(
                                                              // 1);
                                                              Navigator.pop(
                                                                  context);
                                                              // _body(t1l2);
                                                            },
                                                            child: const Text(
                                                                "Level 1")),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                              });
                                                              // customPOIbasedonLevelId(
                                                              // 2);
                                                              Navigator.pop(
                                                                  context);
                                                              // _body(t1l3);
                                                            },
                                                            child: const Text(
                                                                "Level 2")),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                              });
                                                              // customPOIbasedonLevelId(
                                                              //     3);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Level 3")),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                              });
                                                              // customPOIbasedonLevelId(
                                                              //     4);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Level 4")),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(btnPadding),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(7),
                                                  topRight:
                                                      Radius.circular(7))),
                                          child:
                                              Icon(Icons.layers, size: btnSize),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.all(btnPadding),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            // borderRadius:BorderRadius.circular(10)
                                          ),
                                          child: Icon(Icons.directions,
                                              size: btnSize),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(50),
                                                            topRight:
                                                                Radius.circular(
                                                                    50))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);

                                                              // _body(t1l1);
                                                            },
                                                            child: const Text(
                                                                "Terminal 1")),
                                                        TextButton(
                                                            onPressed: () {
                                                              // Navigator.pop(
                                                              //     context);
                                                              // _body(t2l1);
                                                            },
                                                            child: const Text(
                                                                "Terminal 2")),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(btnPadding),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(7),
                                                  bottomRight:
                                                      Radius.circular(7))),
                                          child: Icon(Icons.airplane_ticket,
                                              size: btnSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 5),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: TextFormField(
                                scrollPadding: EdgeInsets.zero,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(0.0),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                    ),
                                    suffixIcon: const Icon(Icons.directions),
                                    hintText: "Search",
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    )),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: myHeight - 48,
                              child: SingleChildScrollView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 5),
                                    Text(
                                      "Explore",
                                      style: TextStyle(
                                          fontSize: fontSize,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    // "assets/symbols/Oval.png",
                                                    "assets/images/restro2.png",
                                                    // "assets/symbols/neww.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "Restaurants",
                                                    style: TextStyle(
                                                        fontSize: fontSize),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/shopping.png",
                                                    height: 35,
                                                    width: 35,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "Shopping",
                                                    style: TextStyle(
                                                        fontSize: fontSize),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/facilities.png",
                                                    height: 35,
                                                    width: 35,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "Facilities",
                                                    style: TextStyle(
                                                        fontSize: fontSize),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/utilities.png",
                                                    height: 35,
                                                    width: 35,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "Utilities",
                                                    style: TextStyle(
                                                        fontSize: fontSize),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                        // Container(
                        //   height: 60,
                        //   // width: 60,
                        //   decoration: const BoxDecoration(
                        //       color: Colors.grey,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(20))),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(3.0),
                        //     child: Flexible(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //             // color: Colors.green,
                        //             // height: 25,
                        //             // width: 25,
                        //             child: Image.asset(
                        //                 "assets/images/location.png"),
                        //           ),
                        //           Container(
                        //             // color: Colors.green,
                        //             // height: 25,
                        //             // width: 25,
                        //             child: Image.asset(
                        //                 "assets/images/location.png"),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
            ),
          ],
        ),
      )),
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(bottom: 100),
      //   color: Colors.amberAccent,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //           backgroundColor: Colors.blue,
      //           child: Icon(Icons.gps_fixed),
      //           onPressed: () {
      //             // _showToast();
      //             controller.animateCamera(
      //                 CameraUpdate.newCameraPosition(_initialCameraPosition));
      //           }),
      //       Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           FloatingActionButton(
      //               backgroundColor: Colors.blue,
      //               child: Icon(Icons.gps_fixed),
      //               onPressed: () {
      //                 // _showToast();
      //                 controller.animateCamera(CameraUpdate.newCameraPosition(
      //                     _initialCameraPosition));
      //               }),
      //           FloatingActionButton(
      //               backgroundColor: Colors.blue,
      //               child: Icon(Icons.gps_fixed),
      //               onPressed: () {
      //                 // _showToast();
      //                 controller.animateCamera(CameraUpdate.newCameraPosition(
      //                     _initialCameraPosition));
      //               }),
      //           FloatingActionButton(
      //               backgroundColor: Colors.blue,
      //               child: Icon(Icons.gps_fixed),
      //               onPressed: () {
      //                 // _showToast();
      //                 controller.animateCamera(CameraUpdate.newCameraPosition(
      //                     _initialCameraPosition));
      //               }),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
