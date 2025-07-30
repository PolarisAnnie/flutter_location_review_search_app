import 'package:flutter/material.dart';
import 'package:location_review_search_app/ui/pages/review/widgets/review_bottom_sheet.dart';
import 'package:location_review_search_app/ui/pages/review/widgets/review_item.dart';

class ReviewPage extends StatelessWidget {
  String title;
  ReviewPage(this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 10),
                ReviewItem('이안류에 휩쓸려갈뻔 했어요', '2025-07-14 23:32:04.478149'),
                ReviewItem('사람이 너무 많았어요', '2025-07-14 23:31:04.478149'),
              ],
            ),
          ),
        ),

        bottomSheet: ReviewBottomSheet(bottomPadding: 50),
      ),
    );
  }
}
