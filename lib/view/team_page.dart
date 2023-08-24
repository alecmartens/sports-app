import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  final String teamName;

  const TeamPage({Key? key, required this.teamName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(teamName)),
      body: Center(child: Text('Details for $teamName')),
    );
  }
}
