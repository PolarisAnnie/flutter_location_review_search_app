import 'package:location_review_search_app/data/model/location_model.dart';
import 'package:location_review_search_app/data/repository/location_repository.dart';
import 'package:riverpod/riverpod.dart';

// 1. 상태 클래스 만들기
class LocationState {
  final List<Location> locations;

  const LocationState({required this.locations});
}

// 2. 뷰모델 만들기
class LocationViewModel extends Notifier<LocationState> {
  // 3. build 함수 재정의해서 초기 상태 리턴
  @override
  LocationState build() {
    return LocationState(locations: []);
  }

  // 4. Repository에서 데이터 받아와서 상태 업데이트 해주기
  Future<void> search(String query) async {
    LocationRepository repository = LocationRepository();
    state = LocationState(locations: await repository.searchPlaces(query));
  }

  // 4-2. 현재 위치 검색 메서드 추가 구현
  Future<void> searchCurrentLocation() async {
    LocationRepository repository = LocationRepository();
    try {
      List<Location> results = await repository.searchCurrentLocation();
      state = LocationState(locations: results);
      print('현재 위치 검색 완료: ${results.length}개 결과');
    } catch (e) {
      print('현재 위치 검색 실패: $e');
    }
  }
}

// 5. 뷰모델 관리자 만들기
final locationViewModelProvider =
    NotifierProvider<LocationViewModel, LocationState>(() {
      return LocationViewModel();
    });
