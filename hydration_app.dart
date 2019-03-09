import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(new HydrationApp());

class HydrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hydration',
      theme: new ThemeData(),
      home: new MyCustomForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          elevation: 0.0,
          title: new Text(
            "HYDRATION",
            style: new TextStyle(
                color: Colors.white,
                fontFamily: 'Coiny',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1.0),
          ),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return new Scaffold(
                            appBar: new AppBar(
                              title: const Text("Options"),
                            ),
                            body: new ListView(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.map),
                                  title: Text('Hydration Stations'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.timeline),
                                  title: Text('Complete Progress'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.person_pin_circle),
                                  title: Text('Friends'),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }),
          ],
          backgroundColor: new Color(0xFF2979FF),
          centerTitle: true),
      body: new HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  double percentage;

  @override
  void initState() {
    super.initState();
    setState(() {
      percentage = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        height: 200.0,
        width: 200.0,
        child: new CustomPaint(
          foregroundPainter: new MyPainter(
              lineColor: Colors.amber,
              completeColor: Colors.blueAccent,
              completePercent: percentage,
              width: 8.0),
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(
                color: Colors.lightBlueAccent,
                splashColor: Colors.blueAccent,
                shape: new CircleBorder(),
                child: new Text(
                  "Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    percentage += 10.0;
                    if (percentage > 100.0) {
                      print("Finished!");
                      percentage = 0.0;
                    }
                  });
                }),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  MyPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
