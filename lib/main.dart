import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sticky_headers/sticky_headers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Visualizer(),
    );
  }
}

class Visualizer extends StatefulWidget {
  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> with SingleTickerProviderStateMixin {

  double lebar = 270;
  double tinggi = 170;
  double bxRadius = 0;
  double opacity = 0.5;
  double brRadius = 10;
  double spRadius = 2;
  double x = 0;
  double y = 0;

  final lebarHolder = TextEditingController();
  final tinggiHolder = TextEditingController();
  final bxHolder = TextEditingController();
  final opacityHolder = TextEditingController();
  final brHolder = TextEditingController();
  final spHolder = TextEditingController();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 550),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutQuad,
    ).drive(Tween(begin: 1, end: 0));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // Title
            Row(
              children: <Widget>[
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
                RotationTransition(
                  turns: animation,
                  child: Container(
                    height: 100,
                    width: 100,
                    child: IconButton(
                      icon: Icon(
                        Icons.replay,
                        size: 60,
                      ),
                      tooltip: "Default",
                      onPressed: () {
                        controller..reset()..forward();
                        setState(() {
                          lebar = 270;
                          tinggi = 170;
                          bxRadius = 0;
                          opacity = 0.5;
                          brRadius = 10;
                          spRadius = 2;
                          x = 0;
                          y = 0;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            // End of Title

            SizedBox(height: 50),

            // Our Model Box
            Center(
              child: Container(
                height: tinggi,
                width: lebar,
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
            // End of our Model Box

            SizedBox(height: 30),

            // Setting
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 30),
              child: Column(
                children: <Widget>[
                  // Box Shadow sub-header
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Box Properties",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // End of sub-header
                  SizedBox(height: 10),

                  // Box Height : | input box |
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Box Width:",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          controller: lebarHolder,
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (1 <= val && val <= 340) {
                                lebar = double.parse(value);
                              } else {
                                lebar = lebar;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${lebar.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // End of Box Height : | i_b |

                  // Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: lebar,
                          onChanged: (value) {
                            lebarHolder.clear();
                            setState(() {
                              lebar = value;
                            });
                          },
                          min: 1,
                          max: 340,
                        ),
                      ),
                    ),
                  ),
                  // End of Slider

                  // Box Height : | input box |
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Box Height:",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          controller: tinggiHolder,
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (1 <= val && val <= 300) {
                                tinggi = double.parse(value);
                              } else {
                                tinggi = tinggi;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${tinggi.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // End of Box Height : | i_b |

                  // Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: tinggi,
                          onChanged: (value) {
                            tinggiHolder.clear();
                            setState(() {
                              tinggi = value;
                            });
                          },
                          min: 1,
                          max: 300,
                        ),
                      ),
                    ),
                  ),
                  // End of Slider

                  // Border Radius : | input box |
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Border Radius:",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          controller: bxHolder,
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (0 <= val && val <= 100) {
                                bxRadius = double.parse(value);
                              } else {
                                bxRadius = bxRadius;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${bxRadius.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // End of Border Radius : | i_b |

                  // Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: bxRadius,
                          onChanged: (value) {
                            bxHolder.clear();
                            setState(() {
                              bxRadius = value;
                            });
                          },
                          min: 0,
                          max: 100,
                        ),
                      ),
                    ),
                  ),
                  // End of Slider

                  // Box Shadow sub-header
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Box Shadow",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // End of sub-header
                  SizedBox(height: 10),

                  // Offset
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Offset (x, y):",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (0 <= val && val <= 100) {
                                x = double.parse(value);
                              } else {
                                x = x;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${x.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (0 <= val && val <= 100) {
                                y = double.parse(value);
                              } else {
                                y = y;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${y.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // End of Offset
                  SizedBox(height: 20),

                  // Opacity : | input box |
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Opacity:",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          controller: opacityHolder,
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (0 <= val && val <= 1) {
                                opacity = double.parse(value);
                              } else {
                                opacity = opacity;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${opacity.toStringAsPrecision(3)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // End of Opacity : | i_b |

                  // Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: opacity,
                          onChanged: (value) {
                            opacityHolder.clear();
                            setState(() {
                              opacity = value;
                            });
                          },
                          min: 0,
                          max: 1,
                        ),
                      ),
                    ),
                  ),
                  // End of Slider

                  // Blur Radius : | input box |
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Blur Radius:",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          controller: brHolder,
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (0 <= val && val <= 50) {
                                brRadius = double.parse(value);
                              } else {
                                brRadius = brRadius;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${brRadius.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // End of Blur Radius : | i_b |

                  // Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: brRadius,
                          onChanged: (value) {
                            brHolder.clear();
                            setState(() {
                              brRadius = value;
                            });
                          },
                          min: 0,
                          max: 50,
                        ),
                      ),
                    ),
                  ),
                  // End of Slider

                  // Spread Radius : | input box |
                  Row(
                    children: <Widget>[
                      Container(
                        width: 125,
                        child: Text(
                          "Spread Radius:",
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 55,
                        child: TextField(
                          controller: spHolder,
                          onChanged: (value) {
                            setState(() {
                              double val = double.parse(value);
                              if (-100 <= val && val <= 100) {
                                spRadius = double.parse(value);
                              } else {
                                spRadius = spRadius;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "${spRadius.toStringAsPrecision(4)}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // End of Spread Radius : | i_b |

                  // Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: spRadius,
                          onChanged: (value) {
                            spHolder.clear();
                            setState(() {
                              spRadius = value;
                            });
                          },
                          min: -100,
                          max: 100,
                        ),
                      ),
                    ),
                  ),
                  // End of Slider
                ],
              ),
            ),
            // End of Setting
            SizedBox(height: 20), // I'm not proud of this
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
