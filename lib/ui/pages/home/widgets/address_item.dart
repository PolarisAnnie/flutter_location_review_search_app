import 'package:flutter/material.dart';
import 'package:location_review_search_app/ui/pages/review/review_page.dart';

// 검색 결과로 나온 각 장소 정보를 카드 형태로 표시하는 위젯
// 탭하면 해당 장소의 리뷰 페이지로 이동

class AddressItem extends StatelessWidget {
  String title;
  String category;
  String roadAddress;
  String mapX;
  String mapY;

  AddressItem(
    this.title,
    this.category,
    this.roadAddress,
    this.mapX,
    this.mapY, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 카드 탭 시 리뷰 페이지로 이동
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // 장소 정보와 좌표를 ReviewPage에 전달
              return ReviewPage(title, mapX, mapY);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(category, style: TextStyle(fontSize: 13)),
                Text(roadAddress, style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
