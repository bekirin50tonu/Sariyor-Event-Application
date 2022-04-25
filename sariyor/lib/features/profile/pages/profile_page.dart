import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sariyor/enums/image_route_enum.dart';
import 'package:sariyor/features/auth/service/auth_module.dart';
import 'package:sariyor/widgets/profile_card_field.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({Key? key, required this.sehir, required this.userName})
      : super(key: key);
  String sehir;
  String userName;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBarWidget(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            ImageRouteType.profile.url(Auth.user!.imagePath!) ??
                                "123"),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    alignment: const Alignment(0, 0),
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(ImageRouteType.profile
                                          .url(Auth.user!.imagePath!) ??
                                      "123")),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(90)),
                        ),
                        Text(Auth.user!.fullName),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) =>
                                    buildProfileUpdateWidget(context));
                          },
                          child: const Text('Profili Düzenle'),
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2.0, color: Colors.black),
                              minimumSize: const Size(150, 40),
                              primary: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 100,
                      color: Colors.transparent,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ProfileCard(userName: 'Bekir'),
                          ProfileCard(userName: 'Bekir'),
                          ProfileCard(userName: 'Bekir'),
                          ProfileCard(userName: 'Bekir'),
                          ProfileCard(userName: 'Bekir'),
                          ProfileCard(userName: 'Bekir'),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBarWidget(),
      floatingActionButton: buildFloatingActionButtonWidget(context),
    );
  }

  Widget buildProfileUpdateWidget(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        children: const [Text('Profil Düzenleme Kısmı Gelecek!')],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButtonWidget(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 85, 72, 164),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (_) => buildDraggableCreateEvent(context));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget buildDraggableCreateEvent(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text('Etkinlik Ekleme Buraya Gelecek!!!'))
      ],
    );
  }

  Widget buildBottomNavigationBarWidget() {
    return BottomAppBar(
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
      color: const Color.fromARGB(255, 85, 72, 164),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.airplanemode_active_outlined),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 35,
            color: Colors.white70,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            iconSize: 35,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      centerTitle: true,
      title: const Image(
        height: 50,
        fit: BoxFit.scaleDown,
        image: AssetImage('images/image17.png'),
      ),
    );
  }
}
