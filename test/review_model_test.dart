import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:location_review_search_app/data/model/review_model.dart';

void main() {
  String jsonString = """
    {
      "mapX": "123445",
      "id": "1", 
      "content": "짱이에요", 
      "mapY": "343533", 
      "createdAt": "2025-07-30T20:40:00.000Z"
    }
""";

  test('Review Model test', () {
    Map<String, dynamic> map = jsonDecode(jsonString);
    Review reviewModel = Review.fromJson(map);

    expect(reviewModel.content, "짱이에요");
  });
}
