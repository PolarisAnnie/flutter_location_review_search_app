import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:location_review_search_app/data/model/location_model.dart';

void main() {
  String jsonString = """
    {
      "title": "<b>서교동</b>주민센터",
      "link": "",
      "category": "공공,사회기관>행정복지센터",
      "description": "",
      "telephone": "",
      "address": "서울특별시 마포구 서교동 478-5 주민자치회",
      "roadAddress": "서울특별시 마포구 동교로15길 7 서교동주민자치회",
      "mapx": "1269146625",
      "mapy": "375551473"
    }
""";

  test('Location Model test', () {
    Map<String, dynamic> map = jsonDecode(jsonString);
    LocationModel locationModel = LocationModel.fromJson(map);

    expect(locationModel.roadAddress, "서울특별시 마포구 동교로15길 7 서교동주민자치회");
  });
}
