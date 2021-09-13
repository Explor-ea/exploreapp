import 'dart:async';

import 'package:exploreapp/explorea_colors.dart';
import 'package:exploreapp/pages/profile.dart';
import 'package:exploreapp/wigets/explorea_fab.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'dart:math' as math;

class InteractiveMap extends StatefulWidget {
  const InteractiveMap({Key? key}) : super(key: key);

  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  late final MapController mapController;
  late final StreamSubscription<MapEvent> subscription;
  //
  // // Enable pinchZoom and doubleTapZoomBy by default

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    subscription = mapController.mapEventStream.listen(onMapEvent);
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
      // do not flood console with move and rotate events
      // print(mapEvent);
    }
  }

  Widget buildMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(48.163, -2.73),
        zoom: 7.0,
        maxZoom: 18,
        minZoom: 5,
        rotation: 0.0,
        nePanBoundary: LatLng(51.305, 8.233),
        swPanBoundary: LatLng(42.33, -5.452),
        slideOnBoundaries: true,
        interactiveFlags: (InteractiveFlag.pinchZoom |
            InteractiveFlag.doubleTapZoom |
            InteractiveFlag.pinchMove |
            InteractiveFlag.drag),
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        buildMap(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 0),
          child: Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ExploreaFab(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profil()));
                  },
                  padding: const EdgeInsets.all(8.0),
                  icon: const Icon(Icons.person_outline_sharp),
                ),
                ExploreaFab(
                  onPressed: () {},
                  padding: const EdgeInsets.all(8.0),
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
                ExploreaFab(
                  onPressed: () {},
                  padding: const EdgeInsets.all(8.0),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0, 0, 24.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ExploreaFab(
              onPressed: () {},
              padding: EdgeInsets.all(0),
              icon: const Icon(Icons.view_day_outlined),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 24.0, 24.0),
          child: Align(
              alignment: Alignment.bottomRight,
              child: ExploreaFab(
                onPressed: () {},
                padding: EdgeInsets.all(0),
                icon: Transform.rotate(
                  angle: 30 * (pi / 180),
                  child: new Icon(Icons.navigation_outlined),
                ),
              )),
        ),
      ],
    ));
  }
}
