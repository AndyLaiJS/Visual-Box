import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Visualizer(),
    );
  }
}

class Visualizer extends StatefulWidget {
  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  double bxRadius = 0;
  double opacity = 0.5;
  double brRadius = 10;
  double spRadius = 2;
  double x = 0;
  double y = 0;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Box\nVisualizer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        foreground: Paint()..shader = linearGradient,
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 220,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            // End of Title

            SizedBox(height: 50),

            Center(
              child: Container(
                height: 170,
                width: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bxRadius),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(opacity),
                      blurRadius: brRadius,
                      spreadRadius: spRadius,
                      offset: Offset(x, y),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(top: 50, left: 30),
              child: Row(
                children: <Widget>[
                  Text(
                    "Border Radius:",
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 30,
                    width: 40,
                    child: TextField(
                      onSubmitted: (value) => {
                        setState(() {
                          bxRadius = double.parse(value);
                        }),
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        hintText: "Yo",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5,
                          )
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
