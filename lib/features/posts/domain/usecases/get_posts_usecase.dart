import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetPostsUseCase {
  const GetPostsUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<List<Post>> call() {
    return _repository.getPosts();
  }
}