import 'package:flutter/material.dart';
import 'dart:math';

class Loading extends StatefulWidget {
  String message;
  String avatar;
  Loading(this.message, this.avatar);
  @override
  State createState() => new LoadingState();
}

class LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        duration: Duration(milliseconds: widget.avatar == "wait" ? 1000 : 1000),
        vsync: this);
    // Set animation
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: widget.avatar == "wait" ? Curves.easeOut : Curves.bounceOut);

    _iconAnimation.addListener(() => this.setState(() => {}));
    // Start animation
    _iconAnimationController.repeat();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: widget.avatar == "wait"
                  ? Container(
                      width: _iconAnimation.value * 100,
                      height: 3.5,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.close,
                      size: _iconAnimation.value * 90,
                      color: Colors.red,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            Text(
              widget.message,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
