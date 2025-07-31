import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:location_review_search_app/data/model/location_model.dart';
import 'package:location_review_search_app/data/repository/naver_api_service.dart';

class LocationRepository extends NaverApiService {
  final NaverApiService _naverApi = NaverApiService();

  Future<List<Location>?> search(String query) async {
    if (query.trim().isEmpty) {
      throw ArgumentError('검색어를 입력해주세요');
    }

    final response = await _naverApi.client.get(
      '/v1/search/local.json',
      queryParameters: {'query': query, 'display': 5, 'sort': 'random'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> items = data['items'];

      return items
          .map((json) => Location.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return null;
  }
}
