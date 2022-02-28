enum AdventureDifficulty { EASY, AVERAGE, HARD }

class Adventure {
  final int id;

  final String name;

  final AdventureDifficulty difficulty;

  /// In minutes.
  final int supposedTime;

  /// As [lat, long].
  final List<double> location;

  final String description;

  /// Asset path. Remember to declare the asset in pubspec.
  final String? backgroundPict;

  final int ageRestriction;

  final bool suitableForDisabledPeople;

  const Adventure(
      this.id,
      this.name,
      this.difficulty,
      this.supposedTime,
      this.location,
      this.backgroundPict,
      this.ageRestriction,
      this.suitableForDisabledPeople,
      {this.description = "?"});

  String get difficultyText {
    switch (this.difficulty) {
      case AdventureDifficulty.EASY:
        return "Facile";
        break;

      case AdventureDifficulty.AVERAGE:
        return "Modéré";
        break;

      case AdventureDifficulty.HARD:
        return "Difficile";
        break;

      default:
        return "?";
    }
  }
}
