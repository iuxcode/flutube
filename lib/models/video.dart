class VideoModel {
  final String thumbnail;
  final String title;
  final String publisher;
  final double views;
  final DateTime publishedAt;

  VideoModel({
    required this.thumbnail,
    required this.title,
    required this.publisher,
    required this.views,
    required this.publishedAt,
  });
}
