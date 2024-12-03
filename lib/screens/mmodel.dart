class Movie {
  final String title;
  final String year;
  final String poster;
  final String imdbID;
  final String type;
  

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.imdbID,
    required this.type,
  });

  // Factory constructor to create a Movie object from a JSON map
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'N/A',
      year: json['Year'] ?? 'N/A',
      poster: json['Poster'] ?? '',
      imdbID: json['imdbID'] ?? '',
      type: json['Type'] ?? 'N/A',
    );
  }
}
