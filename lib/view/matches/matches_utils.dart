import 'package:intl/intl.dart';
import '../../enums/sports_league_enum.dart';
import '../../model/match_model.dart';

class MatchUtils {
  static String getCurrentSegment(SportsLeague sportsLeague, Match match) {
  if (match.status.long.startsWith("Inning") || match.status.long == "Postponed") {
    return match.status.long;
  }
  
  if (sportsLeague == SportsLeague.MLB) {
    return match.scores.getLastActiveInning();
  } else if (sportsLeague == SportsLeague.NBA) {
    return match.scores.getLastActiveQuarter();
  }
  return 'Not Started';
}



  static String convertUtcToEstTimeString(String utcTime) {
    // Parse time string to DateTime, considering it's UTC.
    DateTime today = DateTime.now();
    List<String> parts = utcTime.split(':');
    DateTime utcDateTime = DateTime.utc(today.year, today.month, today.day,
        int.parse(parts[0]), int.parse(parts[1]));

    // Convert this UTC DateTime to EST (UTC-5).
    DateTime estDateTime = utcDateTime.subtract(const Duration(hours: 5));

    // Extract and format the hour and minute from the EST DateTime.
    return DateFormat('h:mm a').format(estDateTime);
  }

  static String getLeagueName(SportsLeague league) {
    switch (league) {
      case SportsLeague.MLB:
        return 'MLB';
      case SportsLeague.NFL:
        return 'NFL';
      case SportsLeague.NBA:
        return 'NBA';
      case SportsLeague.NHL:
        return 'NHL';
    }
  }
}
