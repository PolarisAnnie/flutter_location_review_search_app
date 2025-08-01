import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_review_search_app/firebase_options.dart';
import 'package:location_review_search_app/ui/pages/home/home_page.dart';

void main() async {
  // firebase 초기화 코드 추가
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ProviderScope 로 앱을 감싸서 RiverPod이 ViewModel 관리할 수 있게 선언
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
