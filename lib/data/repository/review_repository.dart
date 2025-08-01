import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_review_search_app/data/model/review_model.dart';

class ReviewRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collectionName = 'reviews';

  // 컬렉션 내 mapX, mapY 좌표에 해당하는 리뷰 불러오기
  Future<List<Review>> getReviewsByMap(double mapX, double mapY) async {
    print('Repository getReviewsByMap 호출됨: $mapX, $mapY');
    QuerySnapshot querySnapshot = await firestore
        .collection(collectionName)
        .where('mapX', isEqualTo: mapX.toString()) // 각 좌표에 해당하는 리뷰 필터링
        .where('mapY', isEqualTo: mapY.toString())
        .get(); // 결과 가져오기
    print('Firebase에서 조회된 문서 개수: ${querySnapshot.docs.length}');

    List<DocumentSnapshot> documentSnapshot = querySnapshot.docs;
    List<Review> reviews = documentSnapshot
        .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    print('변환된 Review 객체 개수: ${reviews.length}');

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
