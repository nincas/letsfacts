import 'package:flutter/material.dart';
import './about_page.dart';
import './amount_of_questions.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TotalQuestions()));
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center, // X - pababa
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 200.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.wb_incandescent,
                    size: 80.0,
                    color: Colors.white,
                  ),
                  new Text(
                    "Let's Facts!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    "TAP TO START",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AboutPage()));
                    },
                    splashColor: Colors.lightBlue,
                    color: Colors.white,
                    iconSize: 40.0,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
