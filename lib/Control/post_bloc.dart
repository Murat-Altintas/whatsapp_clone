import 'dart:async';
import 'dart:convert';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:whatsapp_clone/Model/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:whatsapp_clone/utils/extensions.dart';
import '../utils/exceptions.dart';

part './post_event.dart';

part './post_state.dart';

typedef HttpClient = http.Client;

const _postLimit = 30;
const _postDuration = Duration(milliseconds: 100);

EventTransformer<T> postDroppable<T>(Duration duration) {
  return (events, mapper) {
    return droppable<T>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final HttpClient _client;

  List<int> selectAndRemove = [];

  PostBloc({required HttpClient client})
      : _client = client,
        super(PostState()) {
    on<PostFetched>(onPostFetched, transformer: postDroppable(_postDuration));
  }

  Future<void> onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        emit(
          state.copyWith(status: PostStatus.success, posts: posts, hasReachedMax: false),
        );
      }
      final newPosts = await _fetchPosts(state.posts.length);
      newPosts.isEmpty
          ? emit(
        state.copyWith(hasReachedMax: true),
      )
          : emit(
        state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)
            ..addAll(newPosts),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
      PostException(error: _.toString());
    }

  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await _client.get(
      Uri.https(
        "jsonplaceholder.typicode.com",
        "/photos",
        {"_start": "$startIndex", "_limit": "$_postLimit"},
      ),
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>).map((dynamic post) => Post.fromJson(JsonMap.from(post))).toList();
    }
    throw PostException(error: response.body);
  }

  Future<void> removeFromList() async {
    //SOMETHING WRONG AT HERE
    for (var test in selectAndRemove) {
      state.posts.removeAt(test);
      "select and remove: $selectAndRemove".log();
      "current: $state.posts".log();
    }

    final newPosts = state.posts;
    emit(
      state.copyWith(posts: List.of(state.posts)
        ..addAll(newPosts), status: PostStatus.success),
    );
  }

  onPressChange() {
    //if "pressed" is in "if", ui is not refreshing with first time.
    if (state.hasReachedMax == false) {
      emit(state.copyWith(onPress: true, hasReachedMax: true));
    } else {
      emit(state.copyWith(onPress: false, hasReachedMax: false));
    }
  }

  onChangeColor() {
    if (state.hasReachedMax == false) {
      emit(state.copyWith(hasReachedMax: true));
    } else {
      emit(state.copyWith(hasReachedMax: false));
    }
  }

}
