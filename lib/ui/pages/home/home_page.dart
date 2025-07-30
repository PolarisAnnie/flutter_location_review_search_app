import 'package:flutter/material.dart';
import 'package:location_review_search_app/ui/pages/home/widgets/address_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  void search(String text) {
    print('search');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus;
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 8),
              AddressItem(
                '삼성1동 주민센터',
                '공공,사회기관>행정복지센터',
                '서울특별시 강남구 봉은사로 616 삼성1동 주민센터',
              ),
              AddressItem(
                '삼성2동 주민센터',
                '공공,사회기관>행정복지센터',
                '서울특별시 강남구 봉은사로 616 삼성2동 주민센터',
              ),
              AddressItem('코엑스', '문화,예술>컨벤션센터', '서울특별시 강남구 영동대로 513'),
            ],
          ),
        ),
      ),
    );
  }
}
