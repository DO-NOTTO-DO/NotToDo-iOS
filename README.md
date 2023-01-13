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

맡은 기능 및 뷰 

**초기세팅 및 탭 바 구현**: 탭 바 모양이 직선으로 깎여 있고 탭 사이 간격이 시스템 탭바와 달라 UIBezierPath와 함수를 구현하여 탭 바 커스텀을 진행했습니다.

**홈 뷰**: 컬렉션 뷰와 FSCalendar를 사용하여 뷰를 구현했습니다. dateFormatter로 현재 달력의 년, 월 정보를 전달하고 홈 뷰, 바텀 시트 뷰, 툴팁 간 데이터 전달을 구현했습니다.

**내 정보 뷰**: 로그인, 비로그인 상태로 enum에 따라 뷰를 재사용 했습니다. 앱잼 내에서는 토큰 값을 서버에서 받아와 실제 로그인 기능은 구현하지 않았습니다.

**온보딩 뷰**: 온보딩 뷰를 구현하였습니다. 홈 뷰로 넘어갈 때 RootViewController를 탭 바로 달아주었습니다.

**바텀 시트 및 재사용 컴포넌트**: 달력 바텀 시트와 디자인 시스템 버튼을 구현하였습니다. enum으로 재사용 가능하도록 처리했습니다.

어려웠던 부분과 극복 방안

홈 뷰 디자인:

홈 뷰 디자인을 구현하는 것이 가장 어려웠습니다. 처음에는 GUI와 그대로 구현하는 거만 생각하고 중첩이 3번 되는 구조로 뷰를 짰는데, 서버통신과 데이터 전달 과정에서 복잡함을 깨달았습니다. 아래 순서대로 뷰 구조를 뒤집었습니다.

1. 첫 번째 구조

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/eeca49ce-6c0d-44f8-ad25-7905643e0af0/Untitled.png)

1. 두 번째 구조
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2b6bfe63-efb4-46fe-922d-f6a737f67ded/Untitled.png)
    
2. 세 번째 구조
    
    달력을 cell 0
    
    달력 위에 그래픽과 동기부여 메세지 부분을 section header
    
    낫투두 체크박스와 행동까지 모두 하나의 cell로
    
    즉 cell0을 제외하고 모두 같은 cell 사용
    

세 번째 방법이 중첩구조가 없어 데이터 전달과정에서 앞의 두 구조보다 훨씬 쉽게 서버통신을 할 수 있었습니다.

툴팁 띄우기

툴팁을 체크 박스 위치를 기준으로 잡는 것이 어려웠습니다. 셀에 있는 체크 박스를 기준으로 툴팁 컴포넌트의 위치를 잡아주고 clipsToBounds를 통해 셀 영역을 벗어나도 툴팁이 뜨도록 구현했습니다. 그리고 툴팁 컴포넌트 밖을 누르면 dismiss를 하도록 코드를 작성했는데, 셀 영역에 종속된 컴포넌트이기 때문에 셀 밖을 클릭하면 dismiss가 실행되지 않았습니다. 또한 툴팁이 떠 있는 상태에서 다른 체크박스를 클릭하게 되면 기존에 있었던 툴팁이 사라지지 않고 새로운 여러 개의 툴팁이 뜨는 문제가 발생했습니다.

따라서 배경이 clear이고 툴팁 하나를 가지고 있는 뷰 컨트롤러를 만들어서 체크 박스를 클릭 했을 때 crossDisolve 속성으로 present되도록 구현했습니다. 이때 present될 때 마다 셀의 체크박스를 기준으로 layout을 remake 해주었습니다. 스크롤 될 때 역시 제대로 된 cell 위치를 가져오기 위해 수식을 계산하는 과정에서 scrollView의 contentOffSet 개념에 대해 새로 공부하게 되었습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/938c866c-0165-49dc-a1b0-7e2587712902/Untitled.png)

</div>
</details>
