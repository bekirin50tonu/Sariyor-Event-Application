import 'package:flutter/material.dart';
import 'package:sariyor/enums/image_route_enum.dart';

// ignore: must_be_immutable
class ActivityCard extends StatelessWidget {
  ActivityCard(
      {Key? key,
      required this.id,
      this.imagePath,
      required this.title,
      required this.subtitle,
      required this.onTab})
      : super(key: key);
  int id;
  String? imagePath;
  String title;
  String subtitle;
  VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(10),
        width: 175,
        height: 225,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.grey),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          NetworkImage(ImageRouteType.category.url(imagePath)),
                      fit: BoxFit.scaleDown)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 72, 86)),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 125, 129, 132)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
