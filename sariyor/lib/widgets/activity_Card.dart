import 'package:flutter/material.dart';

class activityCard extends StatelessWidget {
  const activityCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(10),
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
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/beach.jpg'), fit: BoxFit.cover)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                'Sahil Gezintisi',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 51, 72, 86)),
              ),
              Text(
                'Salda Gölü',
                style: TextStyle(color: Color.fromARGB(255, 125, 129, 132)),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
