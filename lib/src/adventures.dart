import 'package:exploreapp/src/adventure_model.dart';

List<Adventure> allAdventures = [
  new Adventure(
    1,
    "Les goêlands contre-attaquent",
    AdventureDifficulty.EASY,
    15,
    [48.04856, -1.74249],
    "assets/adventure-background-pict/seagull-test-img.jpeg",
    15,
    false,
    description: """
    Lorem minim irure eiusmod magna ex nostrud nisi nostrud nisi culpa excepteur id.
    Proident elit duis elit ad voluptate commodo sit consectetur proident qui aliquip ex.
    Commodo deserunt nulla culpa tempor non voluptate fugiat quis ut.
    """,
  ),
  new Adventure(
    2,
    "Lorem culpa mollit",
    AdventureDifficulty.AVERAGE,
    25,
    [48.055569, -1.866993],
    null,
    77,
    true,
    description: """
    Reprehenderit culpa adipisicing irure voluptate do voluptate ut consequat in ut.
    Dolore aliqua mollit officia ea velit.
    """,
  ),
];
