# 💰 Currency Converter App

실시간 환율 변환 앱으로, 최신 환율 정보를 제공하고 다양한 통화 간의 변환을 지원합니다. 



## 프로젝트 개요

- **프로젝트 기간**: 2025년 4월 20일 - 4월 24일
- **UI 구성 및 레이아웃**: `Swift` · `UIKit` · `SnapKit` · `Then`
- **아키텍처 및 설계 패턴**: `Clean Architecture` · `MVVM` · `Action-State`
- **데이터 흐름 관리 방식**: 클로저 기반의 액션 전달 및 상태 처리 구조 설계
- **비즈니스 로직 구현**: `UseCase` 중심의 계층화, `CoreData` + `Alamofire`를 통한 저장소 구현 및 병합 처리



## 학습 목표

- UIKit 코드 기반 UI 설계 및 구성
- SnapKit을 통한 AutoLayout 적용 및 UI 반응형 구현 역량 향상
- MVVM 아키텍처와 클로저를 이용한 데이터 흐름 설계 및 상태 관리
- CoreData 기반의 캐싱 처리 및 로컬 데이터 관리 기술 습득
- Alamofire를 활용한 네트워크 통신 구현 및 비동기 처리 방식 학습
- API 연동 및 JSON 디코딩 구조화, UseCase 중심의 계층 설계 실습
- Clean Architecture 원칙에 따른 계층 분리 및 의존성 주입 구조화 경험



## 주요 기능

| 기능 구분 | 세부 설명 |
|----------|-----------|
| 실시간 환율 조회 | 외부 Open API를 통해 최신 환율 정보를 불러와 UI에 반영 |
| 통화 검색 기능 | UISearchBar를 통해 통화 키워드 검색 필터링 기능 구현 |
| 즐겨찾기 기능 | 특정 통화를 북마크로 저장하여 빠르게 확인 가능 |
| 상승/하락 표시 | 이전 데이터와 비교하여 상승/하락 아이콘으로 시각화 |
| 데이터 병합 처리 | API 데이터와 CoreData 데이터를 병합해 UI에 반영 |
| 다크 모드 지원 | 시스템 설정에 따라 자동 테마 적용 |
| 마지막 화면 저장 기능 | 앱이 종료되고 재실행되었을때 마지막에 열렸던 화면으로 이동 |


## 폴더 구조

```bash
CurrencyConverterHakyung/
├── CurrencyConverter/
│   ├── App/                    # 앱 설정 및 진입점 (AppDelegate, SceneDelegate 등)
│   ├── Data/                   # 데이터 계층 (데이터 매핑, 모델, 저장소 구현)
│   │   ├── Mapper/
│   │   ├── Model/
│   │   ├── RepositoryImpl/
│   │   └── Source/
│   │       ├── Local/
│   │       │   ├── CurrencyCoreData/
│   │       │   ├── UserStateCoreData/
│   │       │   └── Mock/
│   │       └── Remote/
│   ├── Domain/                # 도메인 계층 (엔티티, 리포지토리 인터페이스, 유스케이스)
│   │   ├── Entity/
│   │   │   └── Currency/
│   │   ├── Repository/
│   │   │   ├── Currency/
│   │   │   └── UserState/
│   │   └── UseCase/
│   │       ├── Impl/
│   │       │   ├── Currency/
│   │       │   └── UserState/
│   │       └── Protocol/
│   │           ├── Currency/
│   │           └── UserState/
│   └── Presentation/          # 프리젠테이션 계층 (UI, ViewModel, Resource)
│       ├── Model/
│       ├── Resources/
│       │   └── Assets/
│       ├── ViewController/
│       │   ├── Calculator/
│       │   │   └── Subview/
│       │   └── Currency/
│       │       └── Subview/
│       └── ViewModel/
```

---

## 트러블슈팅

- **CoreData와 API 데이터 병합 시 문제**  
  - 병합용 UseCase를 만들어, Clean Architecture 원칙에 맞는 계층 분리 해결

- **상승/하락 화살표 UI 미반영**
  - 문제: 날짜를 비교하여 새로운 데이터를 업데이트 하는 과정에서 이전 데이터와 새로운 데이터가 같은 날짜로 저장되어 환율의 변동이 없는 것으로 인식하는 오류 발생
  - 원인: CoreData와 API 데이터를 처리하는 과정에서 서로 다른 데이터 타입의 복잡성으로 잘못된 데이터 바인딩 되어 해결

- **mock 데이터를 우선 적용했을 때 날짜 비교 실패**  
  - 저장 시점 순서 변경 및 `isSameDay` 처리 방식 보완

