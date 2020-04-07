import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIcon;
  Offset lightPosition = Offset(172, 80); // Start lightbox outside view
  GlobalKey _button0 = GlobalKey();
  GlobalKey _button1 = GlobalKey();
  GlobalKey _button2 = GlobalKey();

  getPositions(buttonkey) {
    final RenderBox renderBoxRed = buttonkey.currentContext.findRenderObject();
    final position = renderBoxRed.localToGlobal(Offset.zero);
    // final position = renderBoxRed.;

    // print("POSITION of Red: $positionRed ")
    print(position);
    return lightPosition = position;
  }

  @override
  void initState() {
    selectedIcon = null;
    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    super.initState();
  }

  // _afterLayout(_) {
  //   getPositions(_button0);
  //   getPositions(_button1);
  //   getPositions(_button2);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: 300,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF3B3B3B),
                ),
              ),
              AnimatedPositioned(
                left: lightPosition.dx - 61,
                duration: Duration(milliseconds: 500),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipPath(
                      clipper: LightClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.0, 1.9],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.grey[400],
                              Colors.transparent
                            ])),
                        width: 80,
                        height: selectedIcon == null ? 0 : 80,
                      ),
                    ),
                    Container(
                      color: Color(0xFFF1F1F1),
                      width: 44,
                      height: selectedIcon == null ? 0 : 4,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        key: _button0,
                        iconSize: 34,
                        color: selectedIcon == 0
                            ? Color(0xFFE1E1E1)
                            : Color(0xFF6C6C6C),
                        icon: Icon(Icons.inbox),
                        onPressed: () {
                          setState(() {
                            selectedIcon = 0;
                          });
                          getPositions(_button0);
                        }),
                    IconButton(
                        key: _button1,
                        iconSize: 34,
                        color: selectedIcon == 1
                            ? Color(0xFFE1E1E1)
                            : Color(0xFF6C6C6C),
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          setState(() {
                            selectedIcon = 1;
                          });
                          getPositions(_button1);
                        }),
                    IconButton(
                        key: _button2,
                        iconSize: 34,
                        color: selectedIcon == 2
                            ? Color(0xFFE1E1E1)
                            : Color(0xFF6C6C6C),
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            selectedIcon = 2;
                          });
                          getPositions(_button2);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.relativeMoveTo(20, 0);
    path.lineTo(60, 0.0);
    path.lineTo(80, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(LightClipper oldClipper) => false;
}
