import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_review_search_app/data/model/review_model.dart';
import 'package:location_review_search_app/ui/pages/review/review_view_model.dart';

// 리뷰 입력을 위한 하단 바텀시트 위젯
class ReviewBottomSheet extends ConsumerStatefulWidget {
  final double bottomPadding;
  final String title;
  final String mapX;
  final String mapY;
  const ReviewBottomSheet({
    super.key,
    required this.bottomPadding,
    required this.title,
    required this.mapX,
    required this.mapY,
  });

  @override
  ConsumerState<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends ConsumerState<ReviewBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50 + widget.bottomPadding,
        decoration: BoxDecoration(
          color: Colors.purple[40],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: textEditingController,
            onSubmitted: (value) {
              // 엔터 키 눌렀을 때 실행
              ref
                  .read(reviewViewModelProvider.notifier)
                  .addReview(
                    Review(
                      content: textEditingController.text.trim(),
                      mapX: double.parse(widget.mapX),
                      mapY: double.parse(widget.mapY),
                      createdAt: DateTime.now(),
                    ),
                  );
              textEditingController.clear(); // 입력 후 텍스트 필드 비우기
              FocusScope.of(context).unfocus(); // 키보드 숨기기
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurple[400]!,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
