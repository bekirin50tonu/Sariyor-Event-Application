import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/utils/location/location_manager.dart';
import 'package:sariyor/widgets/appbar_widget.dart';

class MapViewPage extends StatefulWidget {
  MapViewPage({Key? key}) : super(key: key);
  bool selectPos = false;

  LatLng? selectedPos;

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  double lat = 0.0;
  double long = 0.0;
  List<Marker> markers = <Marker>[];

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () async {
          lat = LocationManager.location.latitude;
          long = LocationManager.location.longitude;
          final GoogleMapController controller = await _controller.future;
          controller.moveCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(lat, long), zoom: 14.0)));
          setState(() {});
        },
        child: const Icon(Icons.location_on),
      ),
      body: Stack(
        children: [
          buildGoogleMaps(context),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: widget.selectPos
                      ? () {
                          BlocProvider.of<EventCubit>(context).latLong =
                              widget.selectedPos!;
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text("Devam Et")))
        ],
      ),
    );
  }

  GoogleMap buildGoogleMaps(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        _controller.complete(controller);
      },
      markers: markers.toSet(),
      initialCameraPosition: CameraPosition(target: LatLng(lat, long)),
      onLongPress: (pos) {
        markers.add(
          Marker(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (contextWrap) => Wrap(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {});
                                widget.selectedPos = pos;
                                widget.selectPos = true;
                                Navigator.pop(contextWrap);
                              },
                              child: const Text("Seç"))
                        ],
                      ));
            },
            markerId: MarkerId(Random().nextInt(100).toString()),
            position: pos,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          ),
        );
        setState(() {});
      },
    );
  }
}
