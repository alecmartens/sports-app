import 'package:flutter/material.dart';
import '../../model/match_model.dart';
import '../../enums/sports_league_enum.dart';
import 'matches_utils.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final SportsLeague sportsLeague;
  final String matchStatus;
  final String homeTeam;
  final String awayTeam;
  final String startTimeDisplay;
  final String homeScore;
  final String awayScore;

  const MatchCard({
    Key? key,
    required this.match,
    required this.sportsLeague,
    required this.matchStatus,
    required this.homeTeam,
    required this.awayTeam,
    required this.startTimeDisplay,
    required this.homeScore,
    required this.awayScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _getAssetPath(String teamName, SportsLeague league) {
      final formattedName = teamName.toLowerCase().replaceAll(' ', '_');
      return '${league.toString().split('.').last.toLowerCase()}_teams/$formattedName.png';
    }

    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$homeTeam vs $awayTeam',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (matchStatus == 'Not Started') ...[
              Text(
                'Start Time: $startTimeDisplay',
                style: const TextStyle(fontSize: 16),
              ),
            ] else if (matchStatus == 'Live') ...[
              Text(
                MatchUtils.getCurrentSegment(sportsLeague, match),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Score: $homeScore - $awayScore',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                ),
              ),
            ] else if (matchStatus == 'Finished') ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      homeScore,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: int.parse(homeScore) > int.parse(awayScore)
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                  Image.asset(
                    _getAssetPath(homeTeam, sportsLeague),
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    _getAssetPath(awayTeam, sportsLeague),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      awayScore,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: int.parse(awayScore) > int.parse(homeScore)
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (matchStatus != 'Finished') ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _getAssetPath(homeTeam, sportsLeague),
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    _getAssetPath(awayTeam, sportsLeague),
                    width: 60,
                    height: 60,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
