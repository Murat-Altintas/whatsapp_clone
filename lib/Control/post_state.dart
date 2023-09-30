part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

enum PostsInMainList { remove, share }

class PostState extends Equatable {
  final List<Post> posts;
  final bool hasReachedMax, onLongPress;
  final PostStatus status;

  const PostState({
    this.posts = const <Post>[],
    this.hasReachedMax = false,
    this.onLongPress = false,
    this.status = PostStatus.initial,
  });

  @override
  List<Object?> get props => [posts, hasReachedMax, status];

  PostState copyWith({
    List<Post>? posts,
    bool? hasReachedMax,
    onPress,
    PostStatus? status,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      onLongPress: onPress ?? this.onLongPress,
      status: status ?? this.status,
    );
  }
}

class PostLoading extends PostState {}
class PostSuccess extends PostState {
  final List<Post> post;
  const PostSuccess({required this.post});
}
class PostError extends PostState {}
