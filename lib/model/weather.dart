class Weather {
  final String publicTime;
  final String publicTimeFormatted;
  final String publishingOffice;
  final String title;
  final String link;
  Weather(
      {required this.publicTime,
      required this.publicTimeFormatted,
      required this.publishingOffice,
      required this.title,
      required this.link});
}

class Description {
  final String publicTime;
  final String publicTimeFormatted;
  final String headlineText;
  final String bodyText;
  final String text;
  Description(
      {required this.publicTime,
      required this.publicTimeFormatted,
      required this.headlineText,
      required this.bodyText,
      required this.text});
}

class Detail {
  final String weather;
  final String wind;
  final String wave;
  Detail({required this.weather, required this.wind, required this.wave});

  factory Detail.fromJson(Map<String, dynamic> json) {}
}
