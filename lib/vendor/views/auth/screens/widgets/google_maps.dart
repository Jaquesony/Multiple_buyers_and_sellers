import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalMaps extends StatefulWidget {
  final double latitude;
  final double longitude;
  LatLng? vendor;
  LocalMaps(
      {required this.latitude,
      required this.longitude,
      this.vendor,
      super.key});

  @override
  State<LocalMaps> createState() => _LocalMapsState();
}

class _LocalMapsState extends State<LocalMaps> {
  final cameraPosition =
      CameraPosition(target: LatLng(-6.708981, 39.2063597), zoom: 12);
  final Set<Marker> markers = {};

  @override
  void initState() {
    markers.add(Marker(
        markerId: MarkerId("vendor"),
        position: LatLng(widget.latitude, widget.longitude),
        draggable: (widget.vendor != null) ? true : false,
        onDragEnd: (widget.vendor != null)
            ? (coords) {
                widget.vendor = LatLng(coords.latitude, coords.longitude);
                log(widget.vendor!.latitude.toString() +
                    " : " +
                    widget.vendor!.longitude.toString());
              }
            : null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      markers: markers,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      onLongPress: (widget.vendor == null)
          ? null
          : (coords) {
              widget.vendor = LatLng(coords.latitude, coords.longitude);
              setState(
                () {
                  markers.clear();
                  markers.add(
                    Marker(
                      markerId: MarkerId("vendor"),
                      position: LatLng(coords.latitude, coords.longitude),
                      draggable: (widget.vendor != null) ? true : false,
                      onDragEnd: (widget.vendor != null)
                          ? (coords) {
                              widget.vendor =
                                  LatLng(coords.latitude, coords.longitude);
                              log(
                                widget.vendor!.latitude.toString() +
                                    " : " +
                                    widget.vendor!.longitude.toString(),
                              );
                            }
                          : null,
                    ),
                  );
                },
              );
              log(
                widget.vendor!.latitude.toString() +
                    " : " +
                    widget.vendor!.longitude.toString(),
              );
            },
    );
  }
}
