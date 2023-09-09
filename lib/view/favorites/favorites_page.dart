import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // if using SVG icons
import '../app_bar.dart'; // Import the file
import 'favorite_teams_view.dart';
import '../bottom_nav_bar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context),
      body: const FavoriteTeamsView(),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }
}
