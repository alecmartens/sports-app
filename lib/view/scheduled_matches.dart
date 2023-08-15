// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../enums/sports_league_enum.dart';

// class Match {
//   final String scheduledTime;
//   final Team homeTeam;

//   Match({required this.scheduledTime, required this.homeTeam});

//   factory Match.fromJson(Map<String, dynamic> json) {
//     return Match(
//       scheduledTime: json['scheduled'],
//       homeTeam: Team.fromJson(json['home']),
//     );
//   }
// }

// class Team {
//   final String name;

//   Team({required this.name});

//   factory Team.fromJson(Map<String, dynamic> json) {
//     return Team(
//       name: json['name'],
//     );
//   }
// }

// class ScheduledMatches extends StatefulWidget {
//   final SportsLeague sportsLeague;

//   ScheduledMatches({required this.sportsLeague});

//   @override
//   _ScheduledMatchesState createState() => _ScheduledMatchesState();
// }

// class _ScheduledMatchesState extends State<ScheduledMatches> {
//   late List<Match> scheduledMatches = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchScheduledMatches();
//   }

//   Future<void> fetchScheduledMatches() async {
//     late final String baseUrl;
//     final String apiKey = '3600678522msh93f2d9232f71c63p11e517jsn853942a57f3e'; // Replace with your API key

//     switch (widget.sportsLeague) {
//       case SportsLeague.MLB:
//         baseUrl = 'https://api-football-v1.p.rapidapi.com/v3/mlb/schedule';
//         break;
//       case SportsLeague.NFL:
//         baseUrl = 'https://api-football-v1.p.rapidapi.com/v3/nfl/schedule';
//         break;
//       case SportsLeague.NBA:
//         baseUrl = 'https://api-football-v1.p.rapidapi.com/v3/nba/schedule';
//         break;
//       case SportsLeague.NHL:
//         baseUrl = 'https://api-football-v1.p.rapidapi.com/v3/nhl/schedule';
//         break;
//     }

//     final headers = {
//       'x-rapidapi-key': apiKey,
//       'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
//     };

//     final response = await http.get(Uri.parse(baseUrl), headers: headers);

//     if (response.statusCode == 200) {
//       if (response.body != null && response.body.isNotEmpty) {
//         final data = json.decode(response.body);
//         final matches = data['response'];

//         setState(() {
//           scheduledMatches = matches
//               .map<Match>((matchData) => Match.fromJson(matchData))
//               .toList();
//         });
//       } else {
//         // Handle the case where the response body is empty
//         print('Response body is empty');
//       }
//     } else {
//       throw Exception('Failed to fetch scheduled matches');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String leagueName = '';

//     switch (widget.sportsLeague) {
//       case SportsLeague.MLB:
//         leagueName = 'MLB';
//         break;
//       case SportsLeague.NFL:
//         leagueName = 'NFL';
//         break;
//       case SportsLeague.NBA:
//         leagueName = 'NBA';
//         break;
//       case SportsLeague.NHL:
//         leagueName = 'NHL';
//         break;
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Text(
//             "Scheduled Games for $leagueName",
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         Container(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: scheduledMatches.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Card(
//                 color: Colors.green[50],
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Center(
//                     child: Text(
//                       scheduledMatches[index].scheduledTime,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
