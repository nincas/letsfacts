import 'package:flutter/material.dart';
import './landing_page.dart';

class AboutPage extends StatefulWidget {
  @override
  State createState() => new AboutPageState();
}

class AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double initialSize = 30.0;
  bool isClicked = false;
  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);

    animation = new CurvedAnimation(parent: controller, curve: Curves.ease);

    animation.addListener(() => this.setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: InkWell(
        onLongPress: () {
          this.setState(() {
            controller.repeat();
            isClicked = true;
          });
        },
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LandingPage()),
              (Route route) => route == null);
        },
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0)),
            Center(
              child: Icon(
                Icons.wb_incandescent,
                size: isClicked == false ? 60.0 : animation.value * 70,
                color: Colors.white,
              ),
            ),
            Center(
              child: Container(
                child: Text("Let's Facts App!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Container(
                  height: 5.0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.white),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 15.0),
                child: Text('DESCRIPTION',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
              ),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "\nThis is a simple Quiz App developed using Flutter 1.0, also with the help of YouTube.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontFamily: 'Courier New',
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 18.0),
                child: Text('SOURCES',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
              ),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "\nOpen Trivia Database\n https://opentb.com/",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0,
                        fontFamily: 'Courier New',
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100.0),
            ),
            ListTile(
              title: Text(
                'Niño Casupanan',
                style: TextStyle(color: Colors.white),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://instagram.fmnl15-1.fna.fbcdn.net/vp/aca3cd1513edb878fc49f1ef551d219a/5CB88973/t51.2885-19/s150x150/22710925_1915590965370358_7348985400494391296_n.jpg?_nc_ht=instagram.fmnl15-1.fna.fbcdn.net'),
              ),
              subtitle:
                  Text('Written by', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
