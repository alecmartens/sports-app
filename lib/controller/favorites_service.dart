import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Set<String>> fetchFavorites() async {
    Set<String> favorites = {};

    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = _firestore.collection('users').doc(user.uid);
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        List<dynamic>? teamsFromFirestore = docSnapshot.data()?['favoriteTeams'];
        if (teamsFromFirestore != null) {
          favorites = Set<String>.from(teamsFromFirestore);
        }
      }
    }

    return favorites;
  }

  Future<void> updateFavorites(String team, bool isFavorited) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not found');
    }

    final userDoc = _firestore.collection('users').doc(user.uid);

    if (isFavorited) {
      await userDoc.update({
        'favoriteTeams': FieldValue.arrayRemove([team])
      });
    } else {
      await userDoc.update({
        'favoriteTeams': FieldValue.arrayUnion([team])
      });
    }
  }
}
