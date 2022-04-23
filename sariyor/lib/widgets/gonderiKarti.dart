import 'package:flutter/material.dart';

class GonderiKarti extends StatefulWidget {
  @override
  State<GonderiKarti> createState() => _GonderiKartiState();
}

class _GonderiKartiState extends State<GonderiKarti> {
  Color appBarREngi = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          height: 380,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 167, 167, 167), width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Color.fromARGB(255, 214, 208, 208)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.indigo,
                        image: DecorationImage(
                            image: AssetImage('images/seren.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seren Solmaz',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Gün Batımı Etkinliğine katıldı.',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          Text(
                            '3 saat önce',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          ),
                          SizedBox(width: 50),
                          Text(
                            'KonyaAltı Sahili',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                ],
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://media.istockphoto.com/photos/sun-loungers-under-umbrella-and-palms-on-the-sandy-beach-by-the-ocean-picture-id1226321192?s=612x612'))),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      print(appBarREngi);
                    },
                    icon: Icon(Icons.favorite_sharp),
                    label: Text('Beğen'),
                    style: TextButton.styleFrom(primary: appBarREngi),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.comment),
                    label: Text('Yorum Yap'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                    label: Text('Paylaş'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
