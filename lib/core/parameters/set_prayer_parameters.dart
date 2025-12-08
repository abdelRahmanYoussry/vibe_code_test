class SetPrayerParameters {
  String date;
  bool isPrayed;
  String prayerName;
  SetPrayerParameters({
    required this.date,
    required this.isPrayed,
    required this.prayerName,
  });
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'is_prayed': isPrayed,
      'prayer_name': prayerName,
    };
  }
}
