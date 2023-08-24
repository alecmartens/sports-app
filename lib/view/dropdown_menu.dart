import 'package:flutter/material.dart';
// Import Firestore
import '../model/team_model.dart';
import 'favorites/favorite_team_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controller/favorites_service.dart';

class Dropdown_Menu extends StatefulWidget {
  const Dropdown_Menu({Key? key}) : super(key: key);

  @override
  _Dropdown_MenuState createState() => _Dropdown_MenuState();
}

class _Dropdown_MenuState extends State<Dropdown_Menu> {
  Set<String> favoritedTeams = <String>{};
  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  void _showMenu(BuildContext context, Offset offset) async {
    final String? selectedSport = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: _buildSportItems(),
      elevation: 8.0,
    );

    if (selectedSport != null) {
      _showTeamMenu(context, offset, selectedSport);
    }
  }

  List<PopupMenuEntry<String>> _buildSportItems() {
    return ["MLB", "NBA", "NFL", "NHL"].map((sport) {
      return PopupMenuItem<String>(
        child: Text(sport),
        value: sport,
      );
    }).toList();
  }

  void _showTeamMenu(BuildContext context, Offset offset, String sport) async {
    final selectedTeam = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: _getTeamsForSport(sport).map((team) {
        return PopupMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(team),
              Icon(
                favoritedTeams.contains(team) ? Icons.star : Icons.star_border,
                color:
                    favoritedTeams.contains(team) ? Colors.yellow : Colors.grey,
              ),
            ],
          ),
          value: team,
        );
      }).toList(),
      elevation: 8.0,
    );

    if (selectedTeam != null) {
      _askFavoriteTeam(context, selectedTeam);
    }
  }

  void _askFavoriteTeam(BuildContext context, String team) {
    askFavoriteTeam(context, team, favoritedTeams, (team, isFavorited) async {
      setState(() {
        if (isFavorited) {
          favoritedTeams.remove(team);
        } else {
          favoritedTeams.add(team);
        }
      });

      try {
        await _favoritesService.updateFavorites(team, isFavorited);
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Unable to add to favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  List<String> _getTeamsForSport(String sport) {
    return Team.forSport(sport);
  }

  Future<void> _fetchFavorites() async {
    try {
      Set<String> favorites = await _favoritesService.fetchFavorites();
      setState(() {
        favoritedTeams = favorites;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Unable to fetch favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          final Offset overlayPosition = overlay.localToGlobal(Offset.zero);
          final Offset position = (context.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);
          final Offset offset = Offset(
            position.dx - overlayPosition.dx,
            position.dy -
                overlayPosition.dy +
                (context.findRenderObject() as RenderBox).size.height,
          );
          _showMenu(context, offset);
        },
        child: const Row(
          // mainAxisSize: MainAxisSize.min, // keep the row's size to its content
          children: [
            SizedBox(width: 8), // Add a little spacing between text and icon
            Icon(Icons.menu),
          ],
        ),
      ),
    );
  }
}
