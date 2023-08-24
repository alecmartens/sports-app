import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../team_page.dart';
import '../../controller/favorites_service.dart';

class FavoriteTeamsView extends StatefulWidget {
  const FavoriteTeamsView({Key? key}) : super(key: key);

  @override
  _FavoriteTeamsViewState createState() => _FavoriteTeamsViewState();
}

class _FavoriteTeamsViewState extends State<FavoriteTeamsView> {
  late User user;
  List<String> favoriteTeams =
      []; // initializing it to an empty list as suggested earlier
  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _fetchFavoriteTeams();
  }

  Future<void> _fetchFavoriteTeams() async {
    try {
      final teamsFromFirestore = await _favoritesService.fetchFavorites();
      setState(() {
        favoriteTeams = teamsFromFirestore.toList();
      });
    } catch (e) {
      // Handle the error here, you can use a print statement or display a snackbar
      print("Error fetching favorite teams: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (favoriteTeams.isEmpty) {
      // Show a loading indicator or a message while waiting for data
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Favorites",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favoriteTeams.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TeamPage(teamName: favoriteTeams[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      // leading: Image.asset(
                      //     'path_to_logos/${favoriteTeams[index]}.png'), // adjust path accordingly
                      title: Text(favoriteTeams[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
