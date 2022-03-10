const List<String> monthsStrIds = [
  "JAN",
  "FEV",
  "MAR",
  "AVR",
  "MAI",
  "JUN",
  "JUL",
  "AOU",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];

const List<String> monthsStrings = [
  "janvier",
  "février",
  "mars",
  "avril",
  "mai",
  "juin",
  "juillet",
  "août",
  "septembre",
  "octobre",
  "novembre",
  "décembre"
];

int getIntFromMonth(String month) {
  return monthsStrIds.indexOf(month) + 1;
}

/// [month] must be an integer from 1 to 12.
String getMonthStringIdFromInt(int month) {
  return monthsStrIds.elementAt(month - 1);
}

/// [month] must be an integer from 1 to 12.
String getMonthStringFromInt(int month) {
  return monthsStrings.elementAt(month - 1);
}
