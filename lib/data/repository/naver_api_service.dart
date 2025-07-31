import 'package:dio/dio.dart';

class NaverApiService {
  Dio get client => _client;

  // cliendId, secretKey 할당
  static const String _cliendId = "G4FWJm2_ceRy8bVR2nML";
  static const String _secretKey = "Sud8a9FwzA";

  static final Dio _client = Dio(
    // 초기 설정
    BaseOptions(
      baseUrl: 'https://openapi.naver.com',
      headers: {
        'X-Naver-Client-Id': _cliendId,
        'X-Naver-Client-Secret': _secretKey,
      },
      validateStatus: (status) => true,
    ),
  );
}

//없어도 될듯
// 다른 곳에서 안쓰는 거기 때문에 location repository 내에 넣어도 됨
