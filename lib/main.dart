import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

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

class _VisualizerState extends State<Visualizer>
    with SingleTickerProviderStateMixin {
  double lebar = 270;
  double tinggi = 170;
  double bxRadius = 20;
  double opacity = 0.3;
  double brRadius = 50;
  double spRadius = -11;
  double x = 0;
  double y = 30;

  final colorHolder = TextEditingController();
  final shadowColorHolder = TextEditingController();
  final lebarHolder = TextEditingController();
  final tinggiHolder = TextEditingController();
  final bxHolder = TextEditingController();
  final opacityHolder = TextEditingController();
  final brHolder = TextEditingController();
  final spHolder = TextEditingController();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  // create some values
  Color pickerColor = Color(0xffffffff);
  Color currentColor = Color(0xffffffff);
  String strCurrentColor = "0xffffffff";
  Color shadowPickerColor = Colors.grey;
  Color shadowCurrentColor = Colors.grey;
  String strSCurrentColor = "0xff9e9e9e";

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void shadowChangeColor(Color color) {
    setState(() => shadowPickerColor = color);
  }

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
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 130,
                        child: Text(
                          "Visual\nBox",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 115,
                        child: Container(
                          height: 10,
                          width: 250,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                RotationTransition(
                  turns: animation,
                  child: Container(
                    height: 80,
                    width: 80,
                    child: IconButton(
                      icon: Icon(
                        Icons.replay,
                        size: 50,
                      ),
                      tooltip: "Reset",
                      onPressed: () {
                        controller
                          ..reset()
                          ..forward();
                        setState(() {
                          strCurrentColor = "0xffffffff";
                          currentColor = Color(0xffffffff);
                          pickerColor = Color(0xffffffff);
                          strSCurrentColor = "0xff9e9e9e";
                          shadowCurrentColor = Colors.grey;
                          shadowPickerColor = Colors.grey;
                          lebar = 270;
                          tinggi = 170;
                          bxRadius = 20;
                          opacity = 0.3;
                          brRadius = 50;
                          spRadius = -11;
                          x = 0;
                          y = 30;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 45,
                    ),
                    tooltip: "Copy to ClipBoard",
                    onPressed: () {
                      setState(() {
                        Share.share(
                          """
Container(
  padding: EdgeInsets.all(50), 
  child: Center(
    child: Container(
      height: $tinggi,
      width: $lebar,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular($bxRadius),
        color: $pickerColor,
        boxShadow: [
          BoxShadow(
            color: shadowCurrentColor.withOpacity($opacity),
            blurRadius: $brRadius,
            spreadRadius: $spRadius,
            offset: Offset($x, $y),
          ),
        ],
      ),
    ),
  ),
),
                          """
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            // End of Title

            StickyHeader(
              // Our Model Box
              header: Container(
                padding: EdgeInsets.all(50),
                color: Colors.grey[50],
                child: Center(
                  child: Container(
                    height: tinggi,
                    width: lebar,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(bxRadius),
                      color: pickerColor,
                      boxShadow: [
                        BoxShadow(
                          color: shadowCurrentColor.withOpacity(opacity),
                          blurRadius: brRadius,
                          spreadRadius: spRadius,
                          offset: Offset(x, y),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // End of our Model Box,

              // Setting
              content: Column(
                children: <Widget>[
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

                        // Box Color : | input box |
                        Row(
                          children: <Widget>[
                            Container(
                              width: 125,
                              child: Text(
                                "Box Color:",
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 95,
                              child: InkWell(
                                onTap: () {
                                  // the Color Picker
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: const Text(
                                        "Pick a Color!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: pickerColor,
                                          onColorChanged: changeColor,
                                          showLabel: true,
                                          pickerAreaHeightPercent: 0.8,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() =>
                                                currentColor = pickerColor);
                                            strCurrentColor = currentColor
                                                .toString()
                                                .replaceAll("Color(", "");
                                            strCurrentColor = strCurrentColor
                                                .replaceAll(")", "");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                    // End of Color Picker
                                  );
                                },
                                child: TextField(
                                  enabled: false,
                                  controller: colorHolder,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: "${strCurrentColor}",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(
                                Icons.swap_vert,
                                size: 20,
                              ),
                              tooltip: "Swap to Shadow's Color",
                              onPressed: () {
                                setState(() {
                                  strCurrentColor = strSCurrentColor;
                                  currentColor = shadowCurrentColor;
                                  pickerColor = shadowPickerColor;
                                });
                              },
                            )
                          ],
                        ),
                        // End of Box Color : | i_b |

                        SizedBox(
                          height: 10,
                        ),

                        // Box Width : | input box |
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
                        // End of Box Width : | i_b |

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
                                  hintText:
                                      "${bxRadius.toStringAsPrecision(4)}",
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

                        // Shadow Color : | input box |
                        Row(
                          children: <Widget>[
                            Container(
                              width: 125,
                              child: Text(
                                "Shadow Color:",
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 95,
                              child: InkWell(
                                onTap: () {
                                  // the Color Picker
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: const Text(
                                        "Pick a Color!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: shadowPickerColor,
                                          onColorChanged: shadowChangeColor,
                                          showLabel: true,
                                          pickerAreaHeightPercent: 0.8,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() => shadowCurrentColor =
                                                shadowPickerColor);
                                            strSCurrentColor =
                                                shadowCurrentColor
                                                    .toString()
                                                    .replaceAll("Color(", "");
                                            strSCurrentColor = strSCurrentColor
                                                .replaceAll(")", "");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                    // End of Color Picker
                                  );
                                },
                                child: TextField(
                                  enabled: false,
                                  controller: shadowColorHolder,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: "${strSCurrentColor}",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(
                                Icons.swap_vert,
                                size: 20,
                              ),
                              tooltip: "Swap to Box's Color",
                              onPressed: () {
                                setState(() {
                                  strSCurrentColor = strCurrentColor;
                                  shadowCurrentColor = currentColor;
                                  shadowPickerColor = pickerColor;
                                });
                              },
                            )
                          ],
                        ),
                        // End of Box Color : | i_b |

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
                                  hintText:
                                      "${brRadius.toStringAsPrecision(4)}",
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
                                  hintText:
                                      "${spRadius.toStringAsPrecision(4)}",
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
                ],
              ),
              // End of Setting,
            ),

            SizedBox(height: 10), // I'm not proud of this
            Center(
              child: Text(
                "© What Should I Do?",
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 10,
                )
              ),
            ),
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
