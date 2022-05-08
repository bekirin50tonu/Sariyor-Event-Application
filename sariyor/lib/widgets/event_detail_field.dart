import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/extensions/datetime_extensions.dart';
import 'package:sariyor/features/events/cubit/category_cubit.dart';
import 'package:sariyor/features/events/cubit/discovery_event_cubit.dart';
import 'package:sariyor/features/events/cubit/event_cubit.dart';
import 'package:sariyor/features/user/cubit/user_cubit.dart';

import '../constants/route_constant.dart';
import '../enums/image_route_enum.dart';
import '../features/events/models/base/base_event_model.dart';
import '../utils/router/route_service.dart';
import 'custom_elevated_button.dart';

class EventDetailView extends StatefulWidget {
  EventDetailView({Key? key, required this.event, required this.isJoined})
      : super(key: key);
  Event event;
  bool isJoined;
  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              ImageRouteType.event.url(widget.event.imagePath),
              width: double.infinity,
              height: 300,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        ListTile(
          title: Center(
            child: Text(
              widget.event.name,
              style: context.themeText.headline5,
            ),
          ),
          subtitle: Text(
            widget.event.description,
            textAlign: TextAlign.justify,
            style: context.themeText.headline6,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                onTap: () {
                  BlocProvider.of<UserCubit>(context)
                      .getUserData(widget.event.owner.id);
                  RouteService.instance
                      .push(RouteConstants.profile, widget.event.owner.id);
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      ImageRouteType.profile.url(widget.event.owner.imagePath)),
                ),
                title: const Text("Etkinliği Hazırlayan"),
                subtitle: Text(
                    "${widget.event.owner.fullName} @${widget.event.owner.username}"),
              ),
            ),
            Expanded(
              child: ListTile(
                onTap: () {
                  BlocProvider.of<DiscoveryEventCubit>(context)
                      .getEventsByCategory(widget.event.category.id);

                  RouteService.instance.push(
                      RouteConstants.eventRoute, widget.event.category.id);
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(ImageRouteType.category
                      .url(widget.event.category.imagePath)),
                ),
                title: const Text("Etkinlik Türü"),
                subtitle: Text(widget.event.category.name),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 3,
          child: GoogleMap(
            zoomControlsEnabled: false,
            markers: <Marker>{
              Marker(
                  infoWindow:
                      InfoWindow(title: widget.event.name.toUpperCase()),
                  markerId: MarkerId(widget.event.id.toString()),
                  position: LatLng(widget.event.lat, widget.event.long),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueCyan))
            },
            initialCameraPosition: CameraPosition(
                zoom: 8, target: LatLng(widget.event.lat, widget.event.long)),
          ),
        ),
        Expanded(
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(ImageRouteType.category
                      .url(widget.event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Başlama Tarihi"),
                subtitle:
                    Text(widget.event.startTime.getTimeDifferenceFromNow()),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(ImageRouteType.category
                      .url(widget.event.category.imagePath!)),
                ),
                title: const Text("Etkinlik Bitiş Tarihi"),
                subtitle: Text(widget.event.endTime.getTimeDifferenceFromNow()),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: const Text("Katılım Başlama Tarihi"),
                subtitle:
                    Text(widget.event.startTime.getTimeDifferenceFromNow()),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text("Katılım Bitiş Tarihi"),
                subtitle: Text(widget.event.endTime.getTimeDifferenceFromNow()),
              ),
            ),
          ],
        ),
        widget.isJoined
            ? Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: CustomElevatedButton(
                  label: 'Ayrılmak İstiyorum',
                  onPressed: () {
                    BlocProvider.of<EventCubit>(context)
                        .exitEvent(widget.event.id);
                    widget.isJoined = !widget.isJoined;
                    setState(() {});
                  },
                  disabled: false,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: CustomElevatedButton(
                  label: 'Katılmak İstiyorum',
                  onPressed: () {
                    BlocProvider.of<EventCubit>(context)
                        .joinEvent(widget.event.id);
                    widget.isJoined = !widget.isJoined;
                    setState(() {});
                  },
                  disabled: false,
                ),
              ),
      ],
    );
  }
}
