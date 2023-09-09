import 'package:flutter/material.dart';
import '../../enums/sports_league_enum.dart';
import '../../controller/api_service.dart';
import 'match_card.dart';
import '../../model/match_model.dart';
import 'matches_utils.dart';

class Matches extends StatefulWidget {
  final SportsLeague sportsLeague;
  final String matchStatus;

  const Matches(
      {Key? key, required this.sportsLeague, required this.matchStatus})
      : super(key: key);

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  late List<Match> matchesList = [];

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    try {
      matchesList = await ApiService()
          .fetchMatches(widget.sportsLeague, widget.matchStatus);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching matches: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String leagueName = MatchUtils.getLeagueName(widget.sportsLeague);

    String title = _getTitle(leagueName);
    String emptyMessage = _getEmptyMessage();

    if (widget.matchStatus == 'Not Started') {
      title = 'Scheduled Games for $leagueName';
      emptyMessage = 'No Scheduled Games';
    } else if (widget.matchStatus == 'Live') {
      title = 'Live Games for $leagueName';
      emptyMessage = 'No Live Games';
    } else if (widget.matchStatus == 'Finished') {
      title = 'Finished Games for $leagueName';
      emptyMessage = 'No Finished Games';
    }

    if (matchesList.isEmpty) {
      // && widget.matchStatus == 'Live') {
      // Return an empty Container if there are no live matches
      return Container();
    }

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
        _buildMatchesWidget(emptyMessage),
      ],
    );
  }

  String _getTitle(String leagueName) {
    switch (widget.matchStatus) {
      case 'Not Started':
        return 'Scheduled Games for $leagueName';
      case 'Live':
        return 'Live Games for $leagueName';
      case 'Finished':
        return 'Finished Games for $leagueName';
      default:
        return 'title';
    }
  }

  String _getEmptyMessage() {
    switch (widget.matchStatus) {
      case 'Not Started':
        return 'No Scheduled Games';
      case 'Live':
        return 'No Live Games';
      case 'Finished':
        return 'No Finished Games';
      default:
        return 'emptyMessage';
    }
  }

  Widget _buildMatchesWidget(String emptyMessage) {
    return matchesList.isEmpty
        ? Center(
            child: Text(
              emptyMessage,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          )
        : SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: matchesList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final match = matchesList[index];
                String homeTeamName =
                    match.homeTeam.abbreviation ?? match.homeTeam.name;
                String awayTeamName =
                    match.awayTeam.abbreviation ?? match.awayTeam.name;

                String est = MatchUtils.convertUtcToEstTimeString(match.time);

                String startTimeDisplay;
                if (match.statusLong == 'Finished') {
                  startTimeDisplay =
                      'Final Score: ${match.homeScore.points} - ${match.awayScore.points}';
                } else if (match.statusLong == 'Live') {
                  // Use the getCurrentSegment method to show the current segment (inning/quarter) for live games
                  startTimeDisplay =
                      MatchUtils.getCurrentSegment(widget.sportsLeague, match);
                } else {
                  startTimeDisplay = '$est EST';
                }

                return MatchCard(
                  match: match,
                  sportsLeague: widget.sportsLeague,
                  matchStatus: widget.matchStatus,
                  homeTeam: homeTeamName,
                  awayTeam: awayTeamName,
                  startTimeDisplay: startTimeDisplay,
                  homeScore: match.homeScore.points.toString(),
                  awayScore: match.awayScore.points.toString(),
                );
              },
            ),
          );
  }
}
