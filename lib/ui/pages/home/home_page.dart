import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_review_search_app/data/model/location_model.dart';
import 'package:location_review_search_app/ui/pages/home/home_view_model.dart';
import 'package:location_review_search_app/ui/pages/home/widgets/address_item.dart';
import 'package:location_review_search_app/ui/pages/review/review_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  void search(String text) {
    ref.read(locationViewModelProvider.notifier).search(text);
    print('search');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocationState locationState = ref.watch(locationViewModelProvider);
    return GestureDetector(
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: locationState.locations.length,
            itemBuilder: (context, index) {
              Location location = locationState.locations[index];
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
