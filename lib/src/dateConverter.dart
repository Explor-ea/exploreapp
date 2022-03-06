const List<String> months = [
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

int getIntFromMonth(String month) {
  return months.indexOf(month) + 1;
}

/// [month] must be an integer from 1 to 12.
String getMonthStringIdFromInt(int month) {
  return months.elementAt(month - 1);
}
