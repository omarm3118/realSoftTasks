class MovieConstants {
  static const String movieAPIKey = '60ee0f025a5bb229290e7145054b8c0a';
  static const String movieBaseUrl = 'https://api.themoviedb.org/3/movie/';
  static const String moviePlayingNowEndPoint = 'now_playing';
  static const String moviePopularEndPoint = 'popular';
  static const String movieTopRatedEndPoint = 'top_rated';

  static String concatenateImageURL(String url) =>
      'https://image.tmdb.org/t/p/w500/$url';
}
