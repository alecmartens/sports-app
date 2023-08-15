import 'package:flutter/material.dart';
import 'view/home_page.dart';  // Only if you've separated HomePage into its own file.
import 'package:flutter/rendering.dart';


void main() {
  //Uncomment this to show widget boundaries 
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alec\'s Sports App',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: HomePage(),
    );
  }
}
