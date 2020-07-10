import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _running = true;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  Animatable<Color> color = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.yellow,
      ),
    ),
    TweenSequenceItem(
      weight: 1,
      tween: ColorTween(
        begin: Colors.yellow,
        end: Colors.orange,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: color
                        .evaluate(AlwaysStoppedAnimation(_controller.value)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            !_running
                ? MaterialButton(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Play',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _running = !_running;
                        _start();
                      });
                    },
                  )
                : MaterialButton(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Stop',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _running = !_running;
                        _controller.stop();
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
