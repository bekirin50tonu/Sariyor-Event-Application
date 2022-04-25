import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sariyor/constants/route_constant.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/extensions/context_extensions.dart';
import 'package:sariyor/features/auth/cubit/auth_cubit.dart';
import 'package:sariyor/utils/router/route_service.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  CustomDrawer(
      {Key? key,
      required this.fullName,
      required this.userName,
      required this.userImage})
      : super(key: key);

  String fullName;
  String userName;
  String userImage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
      ),
      elevation: 999,
      backgroundColor: const Color(0xFF8FA2FF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(32.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(35, 31, 206, 19),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        NetworkImage(ImageRouteType.profile.url(userImage)),
                  ),
                  Text(
                    fullName,
                    style: context.themeText.headline5,
                  ),
                  Text(
                    '@$userName',
                    style: context.themeText.headline6,
                  ),
                ],
              )),
          Expanded(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Anasayfa'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profil'),
                  onTap: () =>
                      RouteService.instance.push(RouteConstants.profile, ""),
                ),
                const ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Etkinlikler'),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0x24133211)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Ayarlar',
                    style: context.themeText.headline6,
                  ),
                ),
                ListTile(
                  onTap: () => context.read<AuthCubit>().logout(),
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(
                    'Çıkış Yap',
                    style: context.themeText.headline6,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
