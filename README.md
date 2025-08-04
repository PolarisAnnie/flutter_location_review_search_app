# 📍 지역 검색 & 리뷰 앱

현재 위치 기반 지역 검색과 리뷰 기능을 제공하는 Flutter 앱입니다.

## 🎯 프로젝트 개요

사용자의 현재 위치를 기반으로 주변 장소를 검색하고, 각 장소에 대한 리뷰를 작성하고 조회할 수 있는 모바일 애플리케이션입니다.

## ✨ 주요 기능

### 🔍 검색 기능
- **키워드 검색**: 네이버 API를 통한 장소 검색
- **현재 위치 검색**: GPS 기반 현재 위치 주변 장소 자동 검색
- **실시간 검색 결과**: 검색어 입력 즉시 결과 표시

### 📝 리뷰 기능
- **리뷰 작성**: 각 장소별 리뷰 작성 및 저장
- **리뷰 조회**: 특정 장소의 모든 리뷰 실시간 조회
- **즉시 반영**: 작성한 리뷰 즉시 화면 반영

### 📍 위치 기능
- **현재 위치 감지**: GPS를 통한 정확한 위치 정보 획득
- **주소 변환**: 위도/경도 → 실제 주소 변환 (VWORLD API)
- **위치 기반 검색**: 현재 위치 기반 자동 장소 검색

## 🛠️ 기술 스택

### Frontend
- **Flutter**: 크로스 플랫폼 모바일 앱 개발
- **Dart**: 메인 프로그래밍 언어

### 상태 관리
- **Riverpod**: 현대적인 상태 관리 라이브러리

### 백엔드 & 데이터베이스
- **Firebase Firestore**: NoSQL 실시간 데이터베이스
- **Cloud Firestore**: 리뷰 데이터 저장 및 동기화

### API 연동
- **네이버 지역검색 API**: 장소 정보 조회
- **VWORLD API**: 좌표 → 주소 변환
- **Dio**: HTTP 클라이언트 라이브러리

### 위치 서비스
- **Geolocator**: GPS 위치 정보 수집
- **Permission Handler**: 위치 권한 관리

## 📱 화면 구성

### Home Page
- 검색바를 통한 키워드 검색
- 현재 위치 버튼으로 GPS 기반 검색
- 검색 결과 리스트 표시

### Review Page
- 선택한 장소의 모든 리뷰 표시
- 하단 입력창을 통한 새 리뷰 작성
- 실시간 리뷰 업데이트

## 🏗️ 아키텍처

### MVVM 패턴
```
View (UI) ↔ ViewModel (상태관리) ↔ Repository (데이터)
```

### 폴더 구조
```
lib/
├── data/
│   ├── model/
│   │   ├── location_model.dart
│   │   └── review_model.dart
│   └── repository/
│       ├── location_repository.dart
│       └── review_repository.dart
└── ui/
    ├── pages/
    │   ├── home/
    │   ├── home_page.dart
    │   │   ├── home_view_model.dart
    │   │   └── widgets/
    │   │       └── address_item.dart
    │   └── review/
            ├── review_page.dart
            ├── review_view_model.dart
            └── widgets/
              ├── review_item.dart
              └── review_bottom_sheet.dart

```

## 🔧 설치 및 설정

### 1. 프로젝트 클론
```bash
git clone [repository-url]
cd location_review_search_app
```

### 2. 의존성 설치
```bash
flutter pub get
```

### 3. API 키 설정
```dart
// lib/data/repository/location_repository.dart
static const String _clientId = 'YOUR_NAVER_CLIENT_ID';
static const String _clientSecret = 'YOUR_NAVER_CLIENT_SECRET';

// lib/services/vworld_service.dart
static const String _apiKey = 'YOUR_VWORLD_API_KEY';
```

### 4. Firebase 설정
1. Firebase 프로젝트 생성
2. `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) 추가
3. Firebase CLI를 통한 Flutter 앱 설정

### 5. 권한 설정

**Android** (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

**iOS** (`ios/Runner/Info.plist`)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>현재 위치 기반 검색을 위해 위치 권한이 필요합니다.</string>
```

## 📦 주요 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 상태 관리
  flutter_riverpod: ^2.4.9
  
  # Firebase
  firebase_core: ^2.24.2
  cloud_firestore: ^4.13.6
  
  # HTTP 클라이언트
  dio: ^5.4.0
  
  # 위치 서비스
  geolocator: ^10.1.0
  permission_handler: ^11.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🚀 실행 방법

### 개발 환경 실행
```bash
flutter run
```

### 릴리즈 빌드
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📊 데이터 흐름

### 1. 현재 위치 검색 플로우
```
사용자 터치 → GPS 위치 획득 → VWORLD API (좌표→주소) → 네이버 API 검색 → 결과 표시
```

### 2. 리뷰 작성 플로우
```
리뷰 입력 → ViewModel → Repository → Firebase 저장 → 상태 업데이트 → UI 반영
```

### 3. 리뷰 조회 플로우
```
페이지 진입 → 좌표 기반 쿼리 → Firebase 조회 → 데이터 변환 → 리스트 표시
```

## 🔍 API 명세

### 네이버 지역검색 API
- **Endpoint**: `https://openapi.naver.com/v1/search/local.json`
- **Method**: GET
- **Parameters**: query, display
- **Response**: JSON (장소 정보 배열)

### VWORLD API
- **Endpoint**: `https://api.vworld.kr/req/address`
- **Method**: GET  
- **Parameters**: service, request, point, key
- **Response**: JSON (주소 정보)

## 프로젝트 문서 및 트러블 슈팅
- [프로젝트 문서 및 트러블 슈팅](https://polariseunhee94.notion.site/23f3216a4dd28022bf75e37649e23d18?source=copy_link)
