import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_review_search_app/data/model/location_model.dart';
import 'package:location_review_search_app/ui/pages/home/home_view_model.dart';
import 'package:location_review_search_app/ui/pages/home/widgets/address_item.dart';

// 메인 화면 - 지역 검색 기능을 제공하는 페이지
// 키워드 검색과 현재 위치 기반 검색을 지원

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // 검색창 텍스트 입력을 관리하는 컨트롤러
  TextEditingController textEditingController = TextEditingController();

  //사용자가 검색어를 입력했을 때 실행되는 메서드
  void search(String text) {
    // ViewModel을 통해 네이버 API 검색 요청
    ref.read(locationViewModelProvider.notifier).search(text);
  }

  // // 검색창 컨트롤러 정리, 메모리에서 제거
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel 상태를 감시하여 검색 결과 변화 감지
    LocationState locationState = ref.watch(locationViewModelProvider);
    return GestureDetector(
      // 화면 터치 시 키보드 숨기기
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            maxLines: 1,
            controller: textEditingController,
            onSubmitted: search,
            decoration: InputDecoration(
              hintText: '검색어를 입력해주세요',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            // GPS 현재 위치 검색 버튼
            SizedBox(
              width: 50,
              child: IconButton(
                onPressed: () {
                  // 현재 위치 기반 검색 메서드 실행, GPS → 주소 변환 → 네이버 API 검색 플로우
                  ref
                      .read(locationViewModelProvider.notifier)
                      .searchCurrentLocation();
                },
                icon: Icon(Icons.gps_fixed),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            // 검색 결과 개수만큼 리스트 아이템 생성
            itemCount: locationState.locations.length,
            itemBuilder: (context, index) {
              Location location = locationState.locations[index];
              // 각 검색 결과를 카드 형태로 표시
              // 탭하면 해당 장소의 리뷰 페이지로 이동
              return AddressItem(
                location.title,
                location.category,
                location.roadAddress,
                location.mapx,
                location.mapy,
              );
            },
          ),
        ),
      ),
    );
  }
}
