import 'package:charge_point_map_package_extrawest/charge_point_map_package_extrawest.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  Set<ChargePointMarker> markers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      _asyncInit(context);
    });
  }

  Future<void> _asyncInit(BuildContext context) async {
    await ChargePointMapPackage.initialize(context);
    markers = Set.from([
      ChargePointMarker(
        markerId: MarkerId("new_marker_id"),
        position: LatLng(15, 15),
      ),
    ]);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(15, 15), zoom: 5),
                markers: markers),
      ),
    );
  }
}
