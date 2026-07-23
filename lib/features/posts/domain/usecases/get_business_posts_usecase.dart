import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetBusinessPostsUseCase {
  const GetBusinessPostsUseCase({
    required this._repository,
  });

  final PostsRepository _repository;

  Future<List<Post>> call({
    required String businessId,
  }) {
    return _repository.getBusinessPosts(
      businessId: businessId,
    );
  }
}