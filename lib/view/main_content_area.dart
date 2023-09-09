import 'package:flutter/material.dart';
import 'matches/matches.dart'; // Import the LiveMatches component
import '../enums/sports_league_enum.dart';

class MainContentArea extends StatelessWidget {
  const MainContentArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: const SingleChildScrollView(
        // Wrapping with SingleChildScrollView
        child: Column(
          children: [
            // NewsCarousel(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Matches(sportsLeague: SportsLeague.MLB, matchStatus: "Live"),
                  Matches(
                      sportsLeague: SportsLeague.MLB,
                      matchStatus: "Not Started"),
                  Matches(
                      sportsLeague: SportsLeague.MLB, matchStatus: "Finished"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
