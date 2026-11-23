DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

String formatStayDate(DateTime date) {
  const List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

int? stayNights(DateTime? checkIn, DateTime? checkOut) {
  if (checkIn == null || checkOut == null || !checkOut.isAfter(checkIn)) {
    return null;
  }
  return checkOut.difference(checkIn).inDays;
}
