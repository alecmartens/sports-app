import 'package:flutter/material.dart';
import 'package:sports_app/view/scheduled_matches.dart';
import 'news_carousel.dart';
import 'matches.dart'; // Import the LiveMatches component
import '../enums/sports_league_enum.dart';

class MainContentArea extends StatelessWidget {
  const MainContentArea({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey
      ),
      child: SingleChildScrollView(  // Wrapping with SingleChildScrollView
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            // const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            NewsCarousel(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Matches(sportsLeague: SportsLeague.MLB, matchStatus: "Live"),
                  const SizedBox(height: 20), // Gives some spacing between the sections
                  Matches(sportsLeague: SportsLeague.MLB, matchStatus: "Not Started"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}