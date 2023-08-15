import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../enums/sports_league_enum.dart';
import '../model/match_model.dart';
import '../model/team_model.dart';
import '../controller/api_service.dart';

class Matches extends StatefulWidget {
  final SportsLeague sportsLeague;
  final String matchStatus;

  Matches({required this.sportsLeague, required this.matchStatus});

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  late List<Match> liveMatches = [];

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    try {
      final response = await ApiService.fetchMatches(widget.sportsLeague);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = data['response'];

        if (matches != null && matches is List) {
          setState(() {
            liveMatches = matches
                .map<Match>((matchData) => Match.fromJson(matchData))
                .where((match) {
              final currentInning = match.scores.home.innings.entries
                  .lastWhere(
                    (inning) => inning.value != null,
                    orElse: () => MapEntry('Not Started', null),
                  )
                  .key;

              if (widget.matchStatus == 'Live') {
                return currentInning != 'Not Started';
              } else if (widget.matchStatus == 'Not Started') {
                return currentInning == 'Not Started';
              }
              return false;
            }).toList();
          });
        } else {
          print('Response data is null or not in expected format');
        }
      } else {
        throw Exception('Failed to fetch live matches');
      }
    } catch (e) {
      print('Error fetching matches: $e');
    }
  }

  // This method will convert team names into the correct asset path format
  String _getAssetPath(String teamName, SportsLeague league) {
    // Convert the team name to lowercase and replace spaces with underscores
    final formattedName = teamName.toLowerCase().replaceAll(' ', '_');
    return '${league.toString().split('.').last.toLowerCase()}_teams/$formattedName.png';
  }

  @override
  Widget build(BuildContext context) {
    String leagueName = '';

    switch (widget.sportsLeague) {
      case SportsLeague.MLB:
        leagueName = 'MLB';
        break;
      case SportsLeague.NFL:
        leagueName = 'NFL';
        break;
      case SportsLeague.NBA:
        leagueName = 'NBA';
        break;
      case SportsLeague.NHL:
        leagueName = 'NHL';
        break;
    }

    String title = widget.matchStatus == 'Not Started'
        ? 'Scheduled Games for $leagueName'
        : 'Live Matches for $leagueName';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: liveMatches.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final match = liveMatches[index];

              final startTime = match.time;
              final timeParts = startTime.split(':');
              final hour = int.parse(timeParts[0]);
              final minute = int.parse(timeParts[1]);
              final startTimeInEST = TimeOfDay(hour: hour - 5, minute: minute);

              final now = TimeOfDay.now();
              final currentTimeInEST = TimeOfDay(
                hour: now.hour - 5,
                minute: now.minute,
              );

              final difference = currentTimeInEST.hour * 60 +
                  currentTimeInEST.minute -
                  startTimeInEST.hour * 60 -
                  startTimeInEST.minute;

              String timeDisplay;

              if (difference >= 60) {
                final hoursDifference = difference ~/ 60;
                timeDisplay = '$hoursDifference hours ago';
              } else if (difference > 0) {
                timeDisplay = '$difference minutes ago';
              } else {
                timeDisplay = 'Just started';
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
                        '${match.homeTeam.name} vs ${match.awayTeam.name}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      if (widget.matchStatus == 'Not Started') ...[
                        Text(
                          'Start Time: ${startTimeInEST.format(context)} EST',
                          style: TextStyle(fontSize: 16),
                        ),
                      ] else if (widget.matchStatus == 'Live') ...[
                        Text(
                          'Inning: ${match.scores.home.innings.entries.lastWhere((inning) => inning.value != null, orElse: () => MapEntry('Not Started', null)).key}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Score: ${match.scores.home.total} - ${match.scores.away.total}',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                      // Displaying team logos
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // To center the items in the row
                        children: [
                          // First Image based on home team
                          Image.asset(
                            _getAssetPath(
                                match.homeTeam.name, widget.sportsLeague),
                            width: 50,
                            height: 50,
                          ),
                          // Padding for some space between the images and the 'Versus' text
                          SizedBox(width: 10),

                          // 'Versus' Text in between
                          Text('VS',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),

                          // Padding for some space between the 'Versus' text and the next image
                          SizedBox(width: 10),
                          Image.asset(
                            _getAssetPath(
                                match.awayTeam.name, widget.sportsLeague),
                            width: 50,
                            height: 50,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
