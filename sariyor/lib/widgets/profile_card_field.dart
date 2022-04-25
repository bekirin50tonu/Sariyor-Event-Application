import 'package:flutter/material.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({
    required this.userName,
    Key? key,
  }) : super(key: key);

  String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(35),
              image: DecorationImage(
                  image: NetworkImage(
                      ImageRouteType.profile.url(Auth.user!.imagePath!) ??
                          "123"),
                  fit: BoxFit.cover)),
        ),
        Text(
          userName,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }
}
