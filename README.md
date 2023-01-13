# NotTodo-iOS <img src="https://user-images.githubusercontent.com/65678579/210546300-261c69ca-aa3a-406f-8fee-517c1f12e5c2.png" align=left width=100>
오늘 하루 하지 않을 것을 지키고 더 나은 일상을 경험하세요.
일상 속 규율 지킴이 **낫투두**.

<br>
<img width="1728" alt="아요_과제제출_서비스설명" src="https://user-images.githubusercontent.com/65678579/210533936-ead66a1a-910c-44f6-bb7b-8f94e130332d.png">


## 🫶 NotTodo iOS Developers

<img src="https://user-images.githubusercontent.com/65678579/210243739-e84cf9aa-2315-41b4-be82-df9d3e4cc614.png" width="200"> | <img src="https://user-images.githubusercontent.com/65678579/210243666-cc9c31b1-9b71-4bd4-a260-2a8a30b33550.png" width="200"> | <img src="https://user-images.githubusercontent.com/65678579/210243841-5cb7b6af-4f9d-4e5b-b37c-9034b367923b.png" width="200"> |
:---------:|:----------:|:---------:
강윤서 | 김정은 | 김민서 |
[yungu0010](https://github.com/yungu0010) | [jeongdung-eo](https://github.com/jeongdung-eo) | [minseo205](https://github.com/minseo205) |
<br>

## 💻 Development Environment

<img src ="https://img.shields.io/badge/Swift-5.5-orange?logo=swift" height="25"> <img src ="https://img.shields.io/badge/Xcode-14.2-blue?logo=xcode" height="25"> <img src ="https://img.shields.io/badge/iOS-15.0-white.svg" height="25">

<br>

## 📖 Using Library

라이브러리 | 사용 목적 | Management Tool
:---------:|:----------:|:---------:
Moya | 서버 통신 | SPM
SnapKit | UI Layout | SPM
Then | UI 선언 | SPM
FSCalendar | 캘린더 커스텀 | SPM
Firebase | 푸쉬 알림 | SPM

<br>

## 📌 Code Convention  
[go to NotTodo Code Convention✨](https://github.com/DO-NOTTO-DO/NotToDo-iOS/wiki/%E2%98%81%EF%B8%8F-Code-Convention)

<br>

## 📌 Git Flow 전략  
[go to NotTodo Git Flow✨](https://github.com/DO-NOTTO-DO/NotToDo-iOS/wiki/%F0%9F%8D%80-Git-Flow)

<br>

## 📌 Project Foldering 
```
├── GoogleService-Info.plist
├── NotToDo
│   ├── Application
│   ├── Global
│   │   ├── Extensions
│   │   │   ├── UI
│   │   └── Literals
│   ├── Network
│   │   ├── API
│   │   ├── Base
│   │   ├── DataModel
│   │   └── Service
│   ├── Presentation
│   │   ├── Scene
│   │   │   ├── ViewControllers
│   │   │   └── Views
│   │   ├── Common
│   │   └── TabBar
│   ├── Resource
│   │   ├── Assets
│   │   ├── Colors
│   │   ├── Fonts
│   │   ├── Info.plist
└──-└──-└── Storyboard
```
<br>

## 📌 구현 기능 및 느낀 점
<details>
<summary>윤서</summary>
<div markdown="1">

### 맡은 기능 및 뷰 

**초기세팅 및 탭 바 구현**: 탭 바 모양이 직선으로 깎여 있고 탭 사이 간격이 시스템 탭바와 달라 UIBezierPath와 함수를 구현하여 탭 바 커스텀을 진행했습니다.

**홈 뷰**: 컬렉션 뷰와 FSCalendar를 사용하여 뷰를 구현했습니다. dateFormatter로 현재 달력의 년, 월 정보를 전달하고 홈 뷰, 바텀 시트 뷰, 툴팁 간 데이터 전달을 구현했습니다.

**내 정보 뷰**: 로그인, 비로그인 상태로 enum에 따라 뷰를 재사용 했습니다. 앱잼 내에서는 토큰 값을 서버에서 받아와 실제 로그인 기능은 구현하지 않았습니다.

**온보딩 뷰**: 온보딩 뷰를 구현하였습니다. 홈 뷰로 넘어갈 때 RootViewController를 탭 바로 달아주었습니다.

**바텀 시트 및 재사용 컴포넌트**: 달력 바텀 시트와 디자인 시스템 버튼을 구현하였습니다. enum으로 재사용 가능하도록 처리했습니다.

### 어려웠던 부분과 극복 방안

홈 뷰 디자인:

홈 뷰 디자인을 구현하는 것이 가장 어려웠습니다. 처음에는 GUI와 그대로 구현하는 거만 생각하고 중첩이 3번 되는 구조로 뷰를 짰는데, 서버통신과 데이터 전달 과정에서 복잡함을 깨달았습니다. 아래 순서대로 뷰 구조를 뒤집었습니다.

1. 첫 번째 구조
    </br>
    <img src="https://user-images.githubusercontent.com/83651335/212325937-7e625951-a1d5-4bb2-b5f5-7a6afc6c0783.png" width="200">

2. 두 번째 구조
    </br>
     <img src="https://user-images.githubusercontent.com/83651335/212325953-58eb120d-4639-43a4-94f3-d94e2d32759e.png" width="200">

3. 세 번째 구조
    
    달력을 cell 0
    
    달력 위에 그래픽과 동기부여 메세지 부분을 section header
    
    낫투두 체크박스와 행동까지 모두 하나의 cell로
    
    즉 cell0을 제외하고 모두 같은 cell 사용

세 번째 방법이 중첩구조가 없어 데이터 전달과정에서 앞의 두 구조보다 훨씬 쉽게 서버통신을 할 수 있었습니다.

툴팁 띄우기
</br>
<img src="https://user-images.githubusercontent.com/83651335/212325989-2408e461-f4a2-43d2-898a-cb1fbf947b70.png" width="200"></br>
툴팁을 체크 박스 위치를 기준으로 잡는 것이 어려웠습니다. 셀에 있는 체크 박스를 기준으로 툴팁 컴포넌트의 위치를 잡아주고 clipsToBounds를 통해 셀 영역을 벗어나도 툴팁이 뜨도록 구현했습니다. 그리고 툴팁 컴포넌트 밖을 누르면 dismiss를 하도록 코드를 작성했는데, 셀 영역에 종속된 컴포넌트이기 때문에 셀 밖을 클릭하면 dismiss가 실행되지 않았습니다. 또한 툴팁이 떠 있는 상태에서 다른 체크박스를 클릭하게 되면 기존에 있었던 툴팁이 사라지지 않고 새로운 여러 개의 툴팁이 뜨는 문제가 발생했습니다.

따라서 배경이 clear이고 툴팁 하나를 가지고 있는 뷰 컨트롤러를 만들어서 체크 박스를 클릭 했을 때 crossDisolve 속성으로 present되도록 구현했습니다. 이때 present될 때 마다 셀의 체크박스를 기준으로 layout을 remake 해주었습니다. 스크롤 될 때 역시 제대로 된 cell 위치를 가져오기 위해 수식을 계산하는 과정에서 scrollView의 contentOffSet 개념에 대해 새로 공부하게 되었습니다.

</div>
</details>

<details>
<summary>정은</summary>
<div markdown="1">

### 추천뷰
추천뷰 카테고리는 collectionview로 구현하고 custom tabBar Collectionview아래에 collectionview를 하나 더 깔았습니다. 그리고 그 컬렉션 뷰 cell안에 nested collectionView를 만들어서 각 카테고리에 맞게 데이터가 들어오도록 했습니다. diffable dataSource와 compositional Layout을 사용하여 구현하였는데, 중첩뷰같은 경우 데이터 바인딩하는 부분과 데이터를 다른 뷰로 전달하는 과정에서 데이터가 제대로 넘어오지 않는 이슈가 발생하게 되었습니다. diffable의 경우 마지막에 생성한 nestedcell이 먼저 호출이 되어 화면에 나타나지 않는 것임을 알고, 데이터를 불러오는 부분을 따로 빼줘서 함수로 처리하였습니다.

성취뷰: 전체를 scroll뷰로 깔고, 그 위에 FSCalendar를 UIView로 빼서 구현하고, 그 아래에 segmented controller를 사용해서 각 버튼을 눌렀을 때, 뷰가 전환될 수 있도록 구현했습니다. 

### 어려웠던 부분과 극복 방안

ViewController에서 최대한 View를 따로 빼서 코드를 작성했습니다. 이 과정에 있어서 컬렉션 뷰와 테이블 뷰도 따로  빼서 작성해 주다 보니 데이터 전달 과정에서 에러가 발생했습니다. ViewController - View - TableView로 구조를 짜다 보니 계층이 깊어졌고, View 안에 있는 테이블 뷰의 버튼을 누를 때마다 이미지가 달라져야 하는데 원하는 부분의 이미지가 변하는 것이 아니라 랜덤하게  이미지가 변하는 것을 확인했습니다. 이는 데이터가 reload될 때마다 재사용하는 cell이나 view를 제대로 초기화시켜 주지 않아서 발생하는 문제라는 것을 알게 되었습니다. 이중 계층 구조를 갖기 때문에 하위계층에서 상위계층으로 데이터를 전달하기 위해 closure를 선언하여 해당 버튼이 눌렸을 때 closure의 값이 view에 전달되도록 선언해 두었습니다. 또한, 해당 View에서 cell을 선언한 부분에 closure의 값을 받아서 버튼을 toggle 시키고, data를 reload 시켜 주었더니 랜덤하게 바뀌던 값이 제대로 작동하는 것을 확인하였습니다.

</div>
</details>

<details>
<summary>민서</summary>
<div markdown="1">

### 맡은 기능 및 뷰

낫투두를 생성하는 플로우를 맡았습니다. 생성 플로우는 추가하기 메인 뷰, 검색 기록 뷰, 상황 추가 뷰, 추천 뷰로 구성됩니다.

메인 뷰: 스크롤 뷰에 컴포넌트를 올려서 구현했습니다. UI가 동일한 부분은 생성자에 인자를 넘겨주는 식으로 재사용했습니다. + 버튼을 눌러 실천 행동을 추가할 때 뜨는 셀은 컬렉션 뷰를 사용했습니다. 모든 조건을 충족했을 때만 추가하기 버튼이 활성화 되도록 구현했습니다.

검색 기록 뷰: 컬렉션 뷰를 사용했습니다. 기록을 눌렀을 때 텍스트 필드에 해당 텍스트가 뜨도록 구현했습니다. 입력 완료 후 메인 뷰로 돌아가면 텍스트 필드에 해당 텍스트가 유지됩니다.

상황 추가 뷰: 컬렉션 뷰를 사용했습니다. 셀을 눌렀을 때 텍스트 필드에 해당 텍스트가 뜨도록 구현했습니다. 텍스트 필드에 입력한 글자 수가 계산되어 하단 라벨에 나타납니다. 입력 완료 후 메인 뷰로 돌아가면 ‘입력하기’가 해당 텍스트로 변경됩니다.

추천 뷰: 갓정은 언니가 구현했습니다. 셀을 눌렀을 때 해당 텍스트가 메인 뷰의 실천 행동 셀에 추가됩니다.

### 어려웠던 부분과 극복 방안

초반에 뷰 스케치를 꼼꼼하게 하지 않아 뷰를 갈아 엎는 경우가 있었습니다. 메인 뷰를 처음에 테이블 뷰로 구현했는데, 그 안에 컬렉션 뷰를 활용한 셀을 넣고, 동적으로 높이를 할당하는 데에 어려움을 겪고 테이블 뷰를 포기했습니다. 테이블 뷰에 대한 공부는 되었지만 시간이 많지 않은 부분에서 뷰를 엎은 점이 아쉬웠습니다. 때문에 검색 기록 뷰, 상황 추가 뷰를 구현할 때 뷰 스케치를 다시 하여 이와 같은 상황의 재발을 방지했습니다.

</div>
</details>
