import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sariyor/enums/image_route_enum.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  EventCard(
      {Key? key,
      required this.userName,
      this.userImage,
      required this.eventName,
      this.eventImage,
      required this.timeForHuman,
      required this.locate,
      required this.onTab})
      : super(key: key);
  Color appbarColor = Colors.pink;
  String userName;
  String eventName;
  String? userImage;
  String? eventImage;
  String timeForHuman;
  String locate;
  Function onTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          height: 380,
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 167, 167, 167), width: 2),
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 214, 208, 208)),
          child: InkWell(
            onTap: () => onTab(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      ImageRouteType.profile.url(userImage!),
                    ),
                  ),
                  title: Text(userName),
                  subtitle:
                      Text('$eventName Etkinliğine katıldı.\n$timeForHuman'),
                ),
                eventImage != null
                    ? Expanded(
                        child: Image.network(
                          ImageRouteType.event.url(eventImage!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
                buildFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFooterWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () {
            log(appbarColor.toString());
          },
          icon: const Icon(Icons.favorite_sharp),
          label: const Text('Beğen'),
          style: TextButton.styleFrom(primary: appbarColor),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.comment),
          label: const Text('Yorum Yap'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.share),
          label: const Text('Paylaş'),
        ),
      ],
    );
  }
}


// void ehehe(){
//   Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       child: Image(
//                           image: NetworkImage(
//                               ImageRouteType.profile.url(userImage))),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           userName, // name
//                           style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                         Text(
//                           '$eventName Etkinliğine katıldı.', // event
//                           style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black),
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               timeForHuman, // time for human
//                               style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w200,
//                                   color: Colors.black),
//                             ),
//                             // const SizedBox(width: 50),
//                             // Text(
//                             //   locate, // locate
//                             //   style: const TextStyle(
//                             //       fontSize: 12,
//                             //       fontWeight: FontWeight.bold,
//                             //       color: Colors.black),
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                         onPressed: () {}, icon: const Icon(Icons.more_horiz)),
//                   ],
//                 ),
// }