import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// My main app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// First Page
class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isVisible = true;
  bool isBig = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Animations")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Fade animation
          AnimatedOpacity(
            opacity: isVisible ? 1 : 0,
            duration: Duration(seconds: 1),
            child: Container(
              height: 80,
              width: 80,
              color: Colors.blue,
            ),
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Text("Fade In/Out"),
          ),

          SizedBox(height: 20),

          // Implicit animation
          AnimatedContainer(
            duration: Duration(seconds: 1),
            height: isBig ? 120 : 60,
            width: isBig ? 120 : 60,
            color: Colors.red,
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                isBig = !isBig;
              });
            },
            child: Text("Animate Box"),
          ),

          SizedBox(height: 20),

          // Hero animation + page transition
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => SecondPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: "box",
              child: Container(
                height: 60,
                width: 60,
                color: Colors.orange,
              ),
            ),
          ),

          Text("Tap the box"),
        ],
      ),
    );
  }
}

// Second Page
class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // Staggered animation
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: FadeTransition(
          opacity: controller,
          child: SlideTransition(
            position: Tween(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(controller),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Hero target
                Hero(
                  tag: "box",
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.orange,
                  ),
                ),

                SizedBox(height: 20),

                Text("Staggered Animation"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}