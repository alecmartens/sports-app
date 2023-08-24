class Team {
  static List<String> forSport(String sport) {
    switch (sport) {
      case "MLB":
        return [
          "Arizona Diamondbacks",
          "Atlanta Braves",
          "Baltimore Orioles",
          "Boston Red Sox",
          "Chicago White Sox",
          "Chicago Cubs",
          "Cincinnati Reds",
          "Cleveland Guardians",
          "Colorado Rockies",
          "Detroit Tigers",
          "Houston Astros",
          "Kansas City Royals",
          "Los Angeles Angels",
          "Los Angeles Dodgers",
          "Miami Marlins",
          "Milwaukee Brewers",
          "Minnesota Twins",
          "New York Yankees",
          "New York Mets",
          "Oakland Athletics",
          "Philadelphia Phillies",
          "Pittsburgh Pirates",
          "San Diego Padres",
          "San Francisco Giants",
          "Seattle Mariners",
          "St. Louis Cardinals",
          "Tampa Bay Rays",
          "Texas Rangers",
          "Toronto Blue Jays",
          "Washington Nationals"
        ];
      case "NBA":
        return [
          "Atlanta Hawks",
          "Boston Celtics",
          "Brooklyn Nets",
          "Charlotte Hornets",
          "Chicago Bulls",
          "Cleveland Cavaliers",
          "Dallas Mavericks",
          "Denver Nuggets",
          "Detroit Pistons",
          "Golden State Warriors",
          "Houston Rockets",
          "Indiana Pacers",
          "Los Angeles Clippers",
          "Los Angeles Lakers",
          "Memphis Grizzlies",
          "Miami Heat",
          "Milwaukee Bucks",
          "Minnesota Timberwolves",
          "New Orleans Pelicans",
          "New York Knicks",
          "Oklahoma City Thunder",
          "Orlando Magic",
          "Philadelphia 76ers",
          "Phoenix Suns",
          "Portland Trail Blazers",
          "Sacramento Kings",
          "San Antonio Spurs",
          "Toronto Raptors",
          "Utah Jazz",
          "Washington Wizards"
        ];
      case "NFL":
        return [
          "Arizona Cardinals",
          "Atlanta Falcons",
          "Baltimore Ravens",
          "Buffalo Bills",
          "Carolina Panthers",
          "Chicago Bears",
          "Cincinnati Bengals",
          "Cleveland Browns",
          "Dallas Cowboys",
          "Denver Broncos",
          "Detroit Lions",
          "Green Bay Packers",
          "Houston Texans",
          "Indianapolis Colts",
          "Jacksonville Jaguars",
          "Kansas City Chiefs",
          "Las Vegas Raiders",
          "Los Angeles Chargers",
          "Los Angeles Rams",
          "Miami Dolphins",
          "Minnesota Vikings",
          "New England Patriots",
          "New Orleans Saints",
          "New York Giants",
          "New York Jets",
          "Philadelphia Eagles",
          "Pittsburgh Steelers",
          "San Francisco 49ers",
          "Seattle Seahawks",
          "Tampa Bay Buccaneers",
          "Tennessee Titans",
          "Washington Football Team"
        ];
      case "NHL":
        return [
          "Anaheim Ducks",
          "Arizona Coyotes",
          "Boston Bruins",
          "Buffalo Sabres",
          "Calgary Flames",
          "Carolina Hurricanes",
          "Chicago Blackhawks",
          "Colorado Avalanche",
          "Columbus Blue Jackets",
          "Dallas Stars",
          "Detroit Red Wings",
          "Edmonton Oilers",
          "Florida Panthers",
          "Los Angeles Kings",
          "Minnesota Wild",
          "Montreal Canadiens",
          "Nashville Predators",
          "New Jersey Devils",
          "New York Islanders",
          "New York Rangers",
          "Ottawa Senators",
          "Philadelphia Flyers",
          "Pittsburgh Penguins",
          "San Jose Sharks",
          "Seattle Kraken",
          "St. Louis Blues",
          "Tampa Bay Lightning",
          "Toronto Maple Leafs",
          "Vancouver Canucks",
          "Vegas Golden Knights",
          "Washington Capitals",
          "Winnipeg Jets"
        ];
      default:
        return [];
    }
  }
}
