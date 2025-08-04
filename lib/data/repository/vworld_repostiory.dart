import 'package:dio/dio.dart';

class VWorldRepository {
  final Dio _dio = Dio();

  // 좌표 → 주소 변환 메서드
  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      print('VWorld API 요청: lat=$lat, lng=$lng');
      final response = await _dio.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'data': 'LT_C_ADEMD_INFO',
          'key': 'B1F05D58-54DB-3731-8201-61468A010D81',
          'geomfilter': 'point($lng $lat)',
          'geometry': 'false',
          'size': 100, // Optional
        },
      );
      print('VWorld API 응답 상태: ${response.statusCode}'); // 추가!
      print('VWorld API 응답 데이터: ${response.data}');

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        var addresses = List.of(
          response.data['response']['result']['featureCollection']['features'],
        ).map((e) => e['properties']['full_nm'].toString()).toList();
        print('추출된 주소들: $addresses'); // 추가!
        return addresses;
      }
      return [];
    } catch (e) {
      throw Exception('주소 변환 실패: $e');
    }
  }
}
