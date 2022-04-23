import 'package:flutter/material.dart';

import 'package:sariyor/widgets/gonderiKarti.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Stack(children: [
          ListView(
            children: [
              Material(
                elevation: 2,
                shadowColor: Colors.purple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('images/image17.png'),
                        fit: BoxFit.fitHeight,
                      ),
                      color: Color.fromARGB(255, 85, 72, 164)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GonderiKarti(),
              GonderiKarti(),
              GonderiKarti(),
            ],
          ),
        ]),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(color: Color.fromARGB(255, 85, 72, 164)),
          ),
          Container(
            width: double.infinity,
            height: 70,
            color: Color.fromARGB(255, 85, 72, 164),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  iconSize: 35,
                  color: Colors.white70,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.airplanemode_active_outlined),
                  iconSize: 35,
                  color: Colors.white70,
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Color.fromARGB(255, 78, 84, 89),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white38,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      iconSize: 35,
                      color: Colors.white70,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  iconSize: 35,
                  color: Colors.white70,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                  iconSize: 35,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
