import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_review_search_app/core/geo_locator_helper.dart';
import 'package:location_review_search_app/data/model/location_model.dart';
import 'package:location_review_search_app/data/repository/vworld_repostiory.dart';

class LocationRepository {
  late final Dio _dio;

  LocationRepository() {
    _dio = Dio(
      // 초기 설정
      BaseOptions(
        baseUrl: 'https://openapi.naver.com/v1/search',
        headers: {
          'X-Naver-Client-Id': "G4FWJm2_ceRy8bVR2nML",
          'X-Naver-Client-Secret': "Sud8a9FwzA",
        },
        // 최대 5개 표시, 정확도 순으로 내림차순 정렬
        queryParameters: {'display': 5, 'sort': 'random'},
        // 타임아웃 처리
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
  }

  // 검색 메서드 구현 1. 사용자 입력값 기반 검색 > 다수의 검색 결과가 나올 수 있기 때문에 List 형태로 타입 결정
  Future<List<Location>> searchPlaces(String query) async {
    // 입력값 검증
    query = query.trim();
    if (query.isEmpty) {
      throw ArgumentError('검색어 값이 없습니다');
    }

    // API 호출 코드 작성
    final Response response = await _dio.get(
      '/local.json',
      queryParameters: {'query': query},
    );

    // 데이터 추출 코드 작성
    final List items = response.data['items'] ?? [];

    // Location 객체로 변환
    return items.map((item) => Location.fromJson(item)).toList();
  }

  // 검색 메서드 구현 2. GPS 활용하여 현재 위치 기반 검색
  Future<List<Location>> searchCurrentLocation() async {
    final VWorldRepository vworldRepo = VWorldRepository();

    // 1. GPS로 현재 위치 가져오기
    Position? position = await GeolocatorHelper.getPositon();
    if (position == null) {
      print('위치 권한이 없습니다');
      return [];
    }
    print('GPS 위치: ${position.latitude}, ${position.longitude}');

    // 2. 좌표 → 주소 변환
    List<String> addresses = await vworldRepo.findByLatLng(
      lat: position.latitude,
      lng: position.longitude,
    );

    print('변환된 주소들: $addresses');

    if (addresses.isNotEmpty) {
      // 3. 주소로 네이버 API 검색
      String searchQuery = addresses.last; // 가장 구체적인 주소 사용
      print('현재 위치: $searchQuery');

      List<Location> results = await searchPlaces(searchQuery);
      print('네이버 API 검색 결과: ${results.length}개'); // 추가!

      return results;
    }
    return [];
  }
}
