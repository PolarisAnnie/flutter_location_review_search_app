import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_review_search_app/ui/pages/review/review_view_model.dart';
import 'package:location_review_search_app/ui/pages/review/widgets/review_bottom_sheet.dart';
import 'package:location_review_search_app/ui/pages/review/widgets/review_item.dart';

// 장소에 대한 상세 리뷰 조회 및 작성할 수 있는 페이지 
class ReviewPage extends ConsumerStatefulWidget {
  String title;
  String mapX;
  String mapY;
  ReviewPage(this.title, this.mapX, this.mapY, {super.key});

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  @override
  // ReviewPage에서 페이지 진입 시에만 리뷰 가져옴
  void initState() {
    super.initState();
     // 위젯 빌드 이후에 리뷰 데이터를 불러오기 위한 콜백 등록
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(reviewViewModelProvider.notifier)
          .getReviewByLocation(
            double.parse(widget.mapX),
            double.parse(widget.mapY),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel의 상태를 구독
    ReviewState reviewState = ref.watch(reviewViewModelProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 10),

                // 실제 Firebase 데이터를 동적으로 표시
                ...reviewState.reviews.map(
                  (review) =>
                      ReviewItem(review.content, review.createdAt.toString()),
                ),

                // 리뷰가 없는 경우 메시지 표시
                if (reviewState.reviews.isEmpty)
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text('아직 리뷰가 없습니다.', textAlign: TextAlign.center),
                  ),
              ],
            ),
          ),
        ),

        bottomSheet: ReviewBottomSheet(
          bottomPadding: 50,
          title: widget.title,
          mapX: widget.mapX,
          mapY: widget.mapY,
        ),
      ),
    );
  }
}
