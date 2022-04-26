import 'package:flutter/material.dart';
import 'package:sariyor/features/events/pages/profile_Page.dart';

import '../../../widgets/activity_Card.dart';

class KesfetWidget extends StatefulWidget {
  const KesfetWidget({Key? key}) : super(key: key);

  @override
  State<KesfetWidget> createState() => _KesfetWidgetState();
}

class _KesfetWidgetState extends State<KesfetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      floatingActionButton: buildFloatingActionButtonWidget(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBarWidget(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 100,
                  child: Text(
                    'Yeni Aktiviteler Keşfet',
                    style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 98, 168, 199),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                              child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Etkinlik Ara',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0))),
                          )),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                              label: Text(''),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(60, 60),
                                  elevation: 3,
                                  primary: Color.fromARGB(255, 217, 125, 84),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ))),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              //Dinamik List yapamadım :()

              Column(
                children: [
                  Row(
                    children: [
                      activityCard(),
                    ],
                  ),
                  Row(
                    children: [
                      activityCard(),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
