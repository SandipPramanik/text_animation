import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: TextAnimation(),
    );
  }
}

class TextAnimation extends StatefulWidget {
  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  var firstLetter = "F";
  var buttonText = "Start Animating";
  bool isAnimating = false;

  AnimationController _controller;
  Animation<Offset> _fSlideAnimation,
      _gSlideAnimation,
      _maSlideAnimation,
      _hashSlideAnimation;

  Animation<double> _hashOpacityAnimation;
  Animation<Color> _fColorAnimation, _iColorAnimation, _gColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controller.addListener(() {
      setState(() {});
    });
    _fSlideAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(1.7, 0.0))
        .animate(_controller);
    _gSlideAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(-1.4, 0.0))
        .animate(_controller);
    _maSlideAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(-0.2, 0.0))
        .animate(_controller);
    _hashSlideAnimation = Tween(begin: Offset(1.4, 0.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    _hashOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _fColorAnimation = ColorTween(begin: Colors.white, end: Colors.purple)
        .animate(_controller);
    _iColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(_controller);
    _gColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.green).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).padding.top,
            height: 121.0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "TEXT ANIMATION",
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isAnimating
                  ? SlideTransition(
                      position: _hashSlideAnimation,
                      child: FadeTransition(
                        opacity: _hashOpacityAnimation,
                        child: Container(
                          child: Text(
                            "# ",
                            style: TextStyle(
                              fontSize: 31.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SlideTransition(
                position: _fSlideAnimation,
                child: Container(
                  child: Text(
                    firstLetter + " ",
                    style: TextStyle(
                      fontSize: 31.0,
                      color: _fColorAnimation.value,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "i ",
                  style: TextStyle(
                    fontSize: 31.0,
                    color: _iColorAnimation.value,
                  ),
                ),
              ),
              SlideTransition(
                position: _gSlideAnimation,
                child: Container(
                  child: Text(
                    "g ",
                    style: TextStyle(
                      fontSize: 31.0,
                      color: _gColorAnimation.value,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _maSlideAnimation,
                child: Container(
                  child: Text(
                    "m a",
                    style: TextStyle(
                      fontSize: 31.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )),
          Positioned(
            bottom: 0.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  isAnimating = !isAnimating;
                  if (isAnimating) firstLetter = "f";
                  if (!isAnimating) firstLetter = "F";
                  if (isAnimating) buttonText = "Like it ? 😍";
                  if (!isAnimating) buttonText = "Start Animating";
                });
                if (isAnimating) _controller.forward();
                if (!isAnimating) _controller.reverse();
              },
              child: Container(
                height: 66.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
