import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // if using SVG icons
import 'app_bar.dart'; // Import the file
import 'main_content_area.dart';
import 'bottom_nav_bar.dart';  // Import the BottomNavBar

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context),
      body: const MainContentArea(),
      bottomNavigationBar: BottomNavBar(),  // Add your bottom navigation bar here
    );
  }
}
