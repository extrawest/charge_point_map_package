# charge_point_map_package

A new Flutter package with charge point custom markers.

# Dependence
    package use plugin google_maps_flutter: ^0.5.21+15.

# Preparation
The package serves as an addition to the [google_maps_flutter plugin](https://pub.dev/packages/google_maps_flutter#-readme-tab-).
So, firstly, use their instruction.

# Usage

Future<void> ChargePointMapPackage.initialize(BuildContext context) - async static method for loading
BitmapDescriptor for loading icon. It should be called and executed before creating ChargePointMarker.


class ChargePointMarker - class extend google_maps_flutter.Marker.  All fields are the same except
for the icon field. ChargePointMarker have not this field because the package uses a persistent
custom icon.


# Example
```dart
import 'package:flutter/material.dart';
import 'package:charge_point_map_package/charge_point_map_package.dart';
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
        position: LatLng(0, 0),
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
            initialCameraPosition: CameraPosition(
                target: LatLng(0, 0), zoom: 2),
            markers: markers),
      ),
    );
  }
}

```