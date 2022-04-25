import 'dart:ui';

import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({Key? key, required this.sehir, required this.userName})
      : super(key: key);
  String sehir;
  String userName;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/seren.jpg'),
                            fit: BoxFit.cover)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        alignment: Alignment(0, 0),
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
                                      image: AssetImage('images/seren.jpg')),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(90)),
                            ),
                            Text('Seren Solmaz'),
                            Text(''),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Profili Düzenle'),
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      width: 2.0, color: Colors.black),
                                  minimumSize: Size(150, 40),
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
                          margin: EdgeInsets.only(top: 20),
                          height: 100,
                          color: Colors.transparent,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              profile_Card(userName: 'Bekir'),
                              profile_Card(userName: 'Bekir'),
                              profile_Card(userName: 'Bekir'),
                              profile_Card(userName: 'Bekir'),
                              profile_Card(userName: 'Bekir'),
                              profile_Card(userName: 'Bekir'),
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBarWidget(),
      floatingActionButton: buildFloatingActionButtonWidget(context),
    );
  }
}

class profile_Card extends StatelessWidget {
  profile_Card({
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
                  image: AssetImage('images/seren.jpg'), fit: BoxFit.cover)),
        ),
        Text(
          userName,
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }
}

FloatingActionButton buildFloatingActionButtonWidget(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: const Color.fromARGB(255, 85, 72, 164),
    onPressed: () {
      showModalBottomSheet(
          context: context, builder: (_) => buildDraggableCreateEvent(context));
    },
    child: const Icon(Icons.add),
  );
}

Widget buildDraggableCreateEvent(BuildContext context) {
  return Column(
    children: const [Center(child: Text('Etkinlik Ekleme Buraya Gelecek!!!'))],
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
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    ),
  );
}
