import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_review_search_app/ui/pages/home/home_view_model.dart';

// 앱 내에서는 ProviderScope 에서 ViewModel을 관리하지만
// 테스트 시는 ProviderContainer 가 관리
// HomeViewModel 을 생성자로 생성하면 HomeViewModel 이 관리하는 상태에 접근할 수가 없음!!!
ProviderContainer createContainer() {
  final container = ProviderContainer();
  // 테스트가 끝나면 container를 폐기(dispose)
  addTearDown(container.dispose);
  return container;
}

void main() {
  //
  test('LocationViewModel test', () async {
    final container = createContainer();
    LocationState homeState = container.read(locationViewModelProvider);
    // 초기값 확인
    expect(homeState.locations, []);
    // 검색!
    await container.read(locationViewModelProvider.notifier).search('서초동');

    // 검색 후 상태 업데이트 되는지 확인!
    LocationState homeStateAfterSearch = container.read(
      locationViewModelProvider,
    );
    expect(homeStateAfterSearch.locations != null, true);
    expect(homeStateAfterSearch.locations.isNotEmpty, true);
    // 출력도 한번 해보기
    for (var location in homeStateAfterSearch.locations) {
      print(location.title);
    }
  });
}
