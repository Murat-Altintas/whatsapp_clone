import 'package:equatable/equatable.dart';

typedef JsonMap = Map<String, dynamic>;

class Post extends Equatable {
  final int id;
  final String title, photos;

  const Post({required this.id, required this.title, required this.photos});

  factory Post.fromJson(JsonMap json) {
    return Post(
      id: json['id'],
      title: json['title'],
      //body: json['body'],
      photos: json['thumbnailUrl'],
    );
  }

  @override
  List<Object?> get props => [id, title, photos];
}
