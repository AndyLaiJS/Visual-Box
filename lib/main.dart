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

            SizedBox(height: 30),

            Center(
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bxRadius),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(opacity),
                      blurRadius: brRadius,
                      spreadRadius: spRadius,
                      offset: Offset(x, y),
                    )
                  ]
                ),
              ),
            ),

            SizedBox(height: 30),

            TextField(

            )

          ],
        ),
      ),
    );
  }
}
