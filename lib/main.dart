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
  Alignment lightAlignment;
  Alignment lightBundleAlignment;
  double lightOpacity;

  @override
  void initState() {
    selectedIcon = 'button1';
    lightAlignment = Alignment.topCenter;
    lightBundleAlignment = Alignment.topCenter;
    lightOpacity = 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      appBar: AppBar(
        title: Text('Flutter fly Appbar Challenge'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //! BACKGROUND CONTAINER
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF3B3B3B),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  //! LIGHT BUNDLE
                  Align(
                    alignment: lightBundleAlignment,
                    child: AnimatedOpacity(
                      opacity: lightOpacity,
                      duration: Duration(milliseconds: 200),
                      child: ClipPath(
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
                        ),
                      ),
                    ),
                  ),
                  //! LIGHT BULB
                  AnimatedAlign(
                    duration: Duration(milliseconds: 300),
                    alignment: lightAlignment,
                    onEnd: () {
                      setState(() {
                        lightOpacity = 1;
                        lightBundleAlignment = lightAlignment;
                      });
                    },
                    child: Container(
                      width: 80,
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Color(0xFFF1F1F1),
                        width: 44,
                        height: 3,
                      ),
                    ),
                  ),
                ],
              ),
              //! BUTTON ROW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Button(
                      name: 'button0',
                      selectedIcon: selectedIcon,
                      icon: Icon(Icons.inbox),
                      onClick: () {
                        setState(() {
                          selectedIcon = 'button0';
                          lightAlignment = Alignment.topLeft;
                          lightOpacity = 0;
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
                          lightAlignment = Alignment.topCenter;
                          lightOpacity = 0;
                        });
                      },
                    ),
                    Button(
                      name: 'button2',
                      selectedIcon: selectedIcon,
                      icon: Icon(Icons.search),
                      onClick: () {
                        setState(() {
                          selectedIcon = 'button2';
                          lightAlignment = Alignment.topRight;
                          lightOpacity = 0;
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
  final Icon icon;
  final Function onClick;

  Button({Key key, this.name, this.selectedIcon, this.icon, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 34,
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
