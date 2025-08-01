import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_review_search_app/data/model/review_model.dart';

class ReviewRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collectionName = 'reviews';

  // 컬렉션 내 mapX, mapY 좌표에 해당하는 리뷰 불러오기
  Future<List<Review>> getReviewsByMap(double mapX, double mapY) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(collectionName)
        .where('mapX', isEqualTo: mapX) // 각 좌표에 해당하는 리뷰 필터링
        .where('mapY', isEqualTo: mapY)
        .get(); // 결과 가져오기

    List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
    List<Review> reviews = [];

    for (DocumentSnapshot doc in documentSnapshot) {
      // 각 문서에서 데이터 추출
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Map을 Review 객체로 변환
      Review review = Review.fromJson(data);

      // 리스트에 추가
      reviews.add(review);
    }

    return reviews;
  }

  // 리뷰 데이터 추가
  Future<void> addReview(Review review) async {
    // 문서에 넣을 데이터를 Map으로 변환
    Map<String, dynamic> data = review.toJson();
    // 문서 참조의 set 메서드 안에 생성할 데이터 전달
    await firestore.collection(collectionName).add(data);
  }
}
