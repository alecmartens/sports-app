import 'package:flutter/material.dart';
import 'news_carousel.dart';
import 'matches/matches.dart'; 
import '../enums/sports_league_enum.dart';

class MainContentArea extends StatelessWidget {
  const MainContentArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            NewsCarousel(),
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
                  Matches(
                      sportsLeague: SportsLeague.NBA,
                      matchStatus: "Not Started"),
                  Matches(sportsLeague: SportsLeague.NBA, matchStatus: "Live"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
