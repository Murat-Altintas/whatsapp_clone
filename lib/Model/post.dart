import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

part 'post.g.dart';

@Freezed()
class Post with _$Post {
  @JsonSerializable(
    explicitToJson: true,
  )
  const factory Post({
    required int id,
    required String title,
    @JsonKey(name: 'url') required String photos,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
