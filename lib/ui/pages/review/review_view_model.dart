import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_review_search_app/data/model/review_model.dart';
import 'package:location_review_search_app/data/repository/review_repository.dart';

// 1. 상태 클래스 만들기
class ReviewState {
  final List<Review> reviews;
  ReviewState({required this.reviews});
}

// 2. 뷰 모델 클래스 만들기
class ReviewViewModel extends Notifier<ReviewState> {
  final ReviewRepository repository = ReviewRepository();
  @override
  ReviewState build() {
    return ReviewState(reviews: []);
  }

  // 해당 좌표에 해당하는 모든 리뷰를 가지고 오는 메서드
  Future<void> getReviewByLocation(double mapX, double mapY) async {
    List<Review> reviews = await repository.getReviewsByMap(mapX, mapY);
    state = ReviewState(reviews: reviews);
  }

  // 리뷰 작성 메서드
  Future<void> addReview(Review review) async {
    try {
      await repository.addReview(review);
      // 새 리뷰를 기존 리뷰 목록에 추가
      state = ReviewState(reviews: [...state.reviews, review]);
    } catch (e) {
      print('에러가 발생했어요 : $e');
    }
  }
}

// 3. 뷰모델 관리자 만들기
final reviewViewModelProvider = NotifierProvider<ReviewViewModel, ReviewState>(
  () {
    return ReviewViewModel();
  },
);
