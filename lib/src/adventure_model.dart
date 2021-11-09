enum AdventureDifficulty { EASY, AVERAGE, HARD }

class Adventure {
  final int id;

  final String name;

  final AdventureDifficulty difficulty;

  /// In minutes.
  final int supposedTime;

  /// As [long, lat].
  final List<double> location;

  final String description;

  const Adventure(
      this.id, this.name, this.difficulty, this.supposedTime, this.location,
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
