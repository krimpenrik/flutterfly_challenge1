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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedIcon;

  selectIcon(String name) {
    selectedIcon = name;
  }

  @override
  void initState() {
    selectedIcon = 'button0';
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
        title: Text('Flutter fly Appbar Challenge'),
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
                left: 20.0 - 61,
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
                    Button(
                      name: 'button0',
                      selectedIcon: selectedIcon,
                      icon: Icon(Icons.favorite_border),
                      onClick: () {
                        setState(() {
                          selectedIcon = 'button0';
                        });
                      },
                    ),
                    Button(
                      name: 'button1',
                      selectedIcon: selectedIcon,
                      icon: Icon(Icons.favorite_border),
                      onClick: () {
                        setState(() {
                          selectedIcon = 'button1';
                        });
                      },
                    ),
                    Button(
                      name: 'button2',
                      selectedIcon: selectedIcon,
                      icon: Icon(Icons.favorite_border),
                      onClick: () {
                        setState(() {
                          selectedIcon = 'button2';
                        });
                      },
                    ),
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

class Button extends StatelessWidget {
  final String name;
  final String selectedIcon;
  final Color color = null;
  final Icon icon;
  final double size = 34;
  final Function onClick;

  Button({Key key, this.name, this.selectedIcon, this.icon, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size,
      color: selectedIcon == name ? Color(0xFFE1E1E1) : Color(0xFF6C6C6C),
      icon: icon,
      onPressed: onClick,
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
