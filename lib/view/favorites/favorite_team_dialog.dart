import 'package:flutter/material.dart';
// Import Firestore if you'll be using it in this file

void askFavoriteTeam(BuildContext context, String team,
    Set<String> favoritedTeams, Function updateFavoritedTeams) {
  bool isFavorited = favoritedTeams.contains(team);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isFavorited ? 'Unfavorite Team' : 'Favorite Team'),
      content: Text(isFavorited
          ? 'Would you like to unfavorite $team?'
          : 'Would you like to favorite $team?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(isFavorited ? 'Unfavorite' : 'Favorite'),
          onPressed: () {
            updateFavoritedTeams(team, isFavorited);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
