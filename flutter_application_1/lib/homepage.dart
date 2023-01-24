import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/barriers.dart';
import 'package:flutter_application_1/bird.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  double birdXAxis = 0;
  bool gameHasStarted = false;
  static double barrierXone = 1;

  double barrierXtwo = barrierXone + 1.5;
  double barrierYbottom = 1.1;
  double barrierYtop = -1.1;
  bool birdAlive = true;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });

    //bird is fucked
  }

  bool didTheBirdLive(barrierX, barrierY, topOrBottom) {
    Rect bird =
        Rect.fromLTRB(birdXAxis, birdYaxis, birdXAxis + 0.06, birdYaxis + 0.06);
    Rect pipe;
    if (topOrBottom == "top") {
      pipe = Rect.fromLTRB(barrierX, barrierY, barrierX + 1, barrierY - 1.5);
    } else {
      pipe = Rect.fromLTRB(barrierX, barrierY, barrierX + 1, barrierY - 1.5);
    }
    var intersectedRect = bird.intersect(pipe);
    print(intersectedRect.width);

    return intersectedRect.width < 0 && intersectedRect.height < 0;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        // birdAlive = didTheBirdLive(barrierXone, barrierYbottom, "bottom");
        // if (!birdAlive) {
        //   timer.cancel();
        // }

        birdYaxis = initialHeight - height;
      });

      setState(() {
        if (barrierXone < -1.1) {
          barrierXone += 2;
        } else {
          barrierXone -= 0.03;
        }
      });

      setState(() {
        if (barrierXtwo < -1.1) {
          barrierXtwo += 2;
        } else {
          barrierXtwo -= 0.03;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(birdXAxis, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.lightBlue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted
                        ? Text("")
                        : Text("TAP TO PLAY",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, barrierYtop),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, barrierYbottom),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, barrierYtop),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, barrierYbottom),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 150.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Best",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "10",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
