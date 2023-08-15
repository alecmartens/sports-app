import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // if using SVG icons
import 'package:carousel_slider/carousel_slider.dart';
import 'app_bar.dart'; // Import the file
import 'main_content_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: MainContentArea(),
    );
  }
}
