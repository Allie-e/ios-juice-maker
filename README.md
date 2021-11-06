
## 🥤 Juice Maker

#### 🗓️ 프로젝트 기간: 2021.10.18 - 2021.11.5

#### Contributor
🍓 [Allie](https://github.com/wooyani77) 🥭 [조이](https://github.com/na-young-kwon)

#### Reviewer
🍎 [도미닉](https://github.com/AppleCEO)

##  목차
 * [학습 키워드](#학습-키워드)
 * [프로젝트 설명](#프로젝트-설명)
 * [구현모습](#-✔️-구현모습)
 * [전체 브랜치 전략](#🌳-전체-브랜치-전략)
 * [Step 1](#Step-1.-쥬스메이커-타입-정의)
    * [구현 내용](#🍓-1-1.-구현-내용)
    * [고민했던 점](#🍌-1-2.-고민했던-점)
    * [Trouble Shooting](#🍍-1-3.-Trouble-Shooting)
    * [브랜치 전략](#🥭-1-4.-브랜치-전략)
* [Step 2](#Step-2.-초기화면-기능구현)
    * [구현 내용](#🍓-2-1.-구현-내용)
    * [고민했던 점](#🍌-2-2.-고민했던-점)
    * [Trouble Shooting](#🍍-2-3.-Trouble-Shooting)
    * [브랜치 전략](#🥭-2-4.-브랜치-전략)
* [Step 3](#Step-3.-재고-수정-기능구현)
    * [구현 내용](#🍓-3-1.-구현-내용)
    * [고민했던 점](#🍌-3-2.-고민했던-점)
    * [Trouble Shooting](#🍍-3-3.-Trouble-Shooting)
    * [브랜치 전략](#🥭-3-4.-브랜치-전략)






## ✏️ 학습-키워드
- CustomStringConvertible, CaseIterable  
- Enum - associated value  
- Namespace  
- Git flow  
- MVC
- Computed property
- Class - reference type
- Struct - value type
- UIViewController, UINavigationController, UINavigationBar(Item)
- UILabel, UIStepper, UIButton
- HIG (modality, navigation)
- IBOutlet collection
- NotificationCenter, addObserver
- present, dismiss
- @objc
- Alert
- Access control


## 프로젝트 설명
#### [**구조체와 클래스 선택 이유**]
✔️ `FruitStore` 타입을 클래스로 구현한 이유
- 과일 재고를 앱 내에서 계속 수정해나가야 하므로 참조타입인 클래스로 구현하는 것이 용이하다.
- 값타입에서도 재고수정을 할 수는 있지만 mutating을 쓰나 class를 쓰나 메서드가 모두 mutating keyword가 붙은걸로 가정한다면 동일하므로 class를 선택하는게 나은 것 같다.
- 앱 내에서 과일 재고를 공통적으로 관리해주고 싶을 때, 혹은 singleton 패턴 구현을 필요로 할때 클래스를 사용할 수도 있을 것 같다.
- 과일 별 재고를 통합적으로 관리해줘야하기 때문에 재고에 변동이 생기면 바로 heap에 저장된 실체값이 변해야 한다. 따라서 인스턴스를 생성할 때 값을 복사하기 보단 참조하여 재고를 변경할 수 있는 클래스가 더 적합하다. 여러곳에서 인스턴스를 가지고 있을때 한군데에서 재고값이 수정되면 원본값도 바뀌어야 한다.

<br>

✔️ `JuiceMaker` 타입을 구조체로 구현한 이유
- 참조 타입에 비해 시스템 리소스가 적게 들어가는 이유로, 즉 성능적인 측면으로 구조체를 사용
- JuiceMaker는 주스를 만드는 함수만 가지고 있다. 간단한 메서드들을 캡슐화 하는 것만이 목적이기 때문에 구조체를 사용했다
- 클래스는 참조를 전달하게되는데, 원본 값을 변경하는건지 정확히 파악하기 어렵다. 반면에 구조체는 값만 전달하기 때문에 변경사항에 대해서 개발자가 직관적으로 파악하기 쉽다.
- 클래스가 지원하는 추가 기능들은 복잡성을 증가시킨다 (상속, 힙할당 등 때문에)
- 힙 할당을 피했다
- 공식문서에 디폴트로 구조체를 사용하라고 나와있다
- 메모리에 할당된 값 타입의 데이터를 다른 변수에 복사해도 각각의 인스턴스는 데이터의 유일한 복사값을 가진다.

## ✔️ 구현모습
![](https://i.imgur.com/gjUciOD.gif)

## 🌳 전체 브랜치 전략
![](https://i.imgur.com/EyjUIvG.jpg)
- main: 완성된 프로젝트를 보관하는 브랜치
- develop: 리뷰를 받고 개선한 코드를 보관하는 브랜치
- step1,2,3: 각 스텝의 요구사항을 구현하는 브랜치 / 평소 코드를 작성하는 브랜치


<br>

## Step 1. 쥬스메이커 타입 정의

### 🍓 1-1. 구현 내용

- 과일의 재고를 관리하는 FruitStore 클래스 / 과일의 종류를 나타내는 Fruit 열거형 
- 과일쥬스를 제조하는 JuiceMaker 구조체 / 쥬스 메뉴를 나타내는 Menu 열거형 / 과일 소비량을 관리할 Recipe(name space)
- 프로젝트내에서 일어나는 모든 오류를 관리할 JuiceMakerError


### 🍌 1-2. 고민했던 점

**✔️ 매직넘버 사용 지양**
- 과일을 소비할 때 과일쥬스의 레시피를 하드코딩하지 않고 열거형으로 정리했습니다
- 매직넘버 사용을 지양하고자 Recipe 열거형에 과일 소비량의 namespace를 만들어 관리합니다

**✔️ 에러타입 정의**
- 본 프로젝트에서 나올 수 있는 모든 에러들을 JuiceMakerError 열거형에 정의했습니다
- 또 description으로 에러메세지를 관리하고 있습니다

**✔️ 코드 컨벤션 준수**
- 같은 성격의 변수라는것을 파악하기 쉽게 하기 위해 변수를 유사한 이름으로 맞췄습니다


### 🍍 1-3. Trouble Shooting

1. **의미없는 return을 지양하는것**
    아래 코드에서 guard 문의 파라미터를 enum으로 받고있어서 else 블럭이 실행될 일이 없다고 판단되는데, 이런 경우에도 의미없는 리턴을 해주는 건 지양해야 하는지 고민했습니다.
    ```swift
    func subtractStock(of fruit: Fruit, amount: Int) {
            guard let stock = stockOfFruit[fruit] else { return } // 이 부분
            stockOfFruit[fruit] = stock - amount
        }
    ```
    > ***from Reviewer***
    > 나중에 fruit 에 과일 목록에 없는 값을 넣으면 프로그램이 강제 종료될 수 있을 것 같습니다.  
    > 항상 optional 을 바인딩할 때는 if let, guard let 을 활용해주는 것이 좋습니다.

    의미없는 리턴은 지양해야한다는걸 다시 한 번 알게되었습니다.  
    consumeStock 메서드에서 `guard let`을 -> `if let` 으로 바꿔주었어요!

<br>

2. **개행의 의의**  
    코드를 작성할 때, 개행에도 의미가 있어야한다고 하는데,  
    `가독성 측면에서 개행하는 것` vs `의미를 생각해서 개행하지 않는 것` 중 어떤 방법을 택해야하는지 고민이 되었습니다.

    > ***from Reviewer***
    > 저는 풀어서 쓰는 것을 선호합니다.   
    > 조금 더 익숙해지면 여러 줄의 코드를 한 줄로 동료들과 약속을 정해서 줄여볼 수 있겠지만  
    > 회사에 들어가기 전까지는 길어지더라도 공식문서에 있는 형식으로 작성하는 것을 추천드립니다!

<br>

3. **네이밍 관련 고민**  
    네이밍은 항상 어려운 것 같아요.. 😅 아래 함수의 파라미터 네이밍이 적절한지에대해 고민을 했습니다.
    ```swift
    func consumeTwoKindsOfFruits(first: Fruit, firstAmount: Int, second: Fruit, secondAmount: Int)
    ```

    > ***from Reviewer***
    > 메소드의 네이밍 괜찮다고 생각했습니다. 조금 길어서 어색하게 생각하신 것 같은데요. 네이밍이 명확해지면 길이가 길어져도 괜찮습니다.

<br>

4. **에러타입을 관리하는 방법**
    프로젝트내에서 일어나는 에러를 정의하는 열거형을 어떻게 관리하면 좋을까요? 
    > ***from Reviewer***
    > 열거형, 객체 등은 별도의 파일로 나눠주는 것이 좋습니다.

    - 수정 후
    새로운 파일을 만들어서 에러를 관리하도록 수정
    더불어 지금은 프로젝트가 크지 않아서 에러종류가 많지 않지만,  
    프로젝트가 커지고 에러가 다양해지면 에러타입의 종류를 구분해주는 방법도 있을 것 같다



### 🥭 1-4. 브랜치 전략

![](https://i.imgur.com/sjYiHHr.jpg)


<br>


## Step 2. 초기화면 기능구현

### 🍓 2-1. 구현 내용

- 재고수정 버튼 터치 ➡️ 재고 추가 화면으로 이동
- 각 음료의 주문 버튼 터치 ➡️ 쥬스 제조 및 결과에 따른 alert 표시
- 과일의 재고 변경시 화면에 변경사항 반영

### 🍌 2-2. 고민했던 점
- 재고의 값이 변경을 반영하기 위한 화면간 데이터 전달 방법에 대해 고민했습니다  
- 모델과 컨트롤러가 서로를 모를수록 좋고 + 의존성을 제거하기 위해, 인스턴스가 간접적으로 메세지를 주고 받는 방법 중 하나인 Notification 을 사용했습니다  
- 나중에 재고를 수정하는 뷰 컨트롤러에도 값 변경 이벤트를 전달할 필요가 있기때문에 `Notification` 의 취지에도 적합하다고 생각했습니다. `NotificationCenter`는 1: N 으로 소통을 할 때 적절한 방법입니다. (저희 프로젝트의 경우 `1` = FruitStore, `N` = viewController, StockUpdateController 입니다.)

### 🍍 2-3. Trouble Shooting
- `consumeFruit()` 함수에서 믹스쥬스를 제조할 때, 두가지 과일 중 한 종류의 과일이라도 재고가 부족하다면, 쥬스가 만들어지지 않도록 설계를 했습니다. 그런데, 로직의 오류로 쥬스는 만들어지지 않지만, 재고가 충분한 과일의 재고가 빠지는 오류가 발견되었고, 도미닉의 조언대로 guard문을 분리하는 방법으로 해결했습니다. **감사합니다!**

- checkStock() 함수를 Bool 타입을 반환하는 함수로 변경하면서, 네이밍을 hasEnoughStock()으로 변경했어요. `~을 가지고있는가?`의 의미를 가진다고 생각해서 수정해보았습니다.

- 과일쥬스 주문 버튼을 관리하는 방식에 대해 고민이 되었습니다. 기존의 코드는 각각의 버튼을 개별적으로 사용하고 있고, 아래의 예시 코드에서는 버튼을 한곳에서 관리할 수 있도록 해보았습니다. 아래의 코드처럼 한 곳에서 관리한다면, 각각의 메서드로 나누는 것보다 코드가 여기저기 돌아다니지 않는다는? 장점이 있는 것 같기도 해요. 두가지 방법 중 어떤 방법이 나은 것인지 도팀장님의 의견이 궁금합니다 :smile: 
```swift
    @IBAction func orderJuice(_ sender: UIButton) {
        
        switch sender.tag {
            
        case JuiceMaker.Menu.strawberryJuice.menuNumber:
            
            juiceMaker.makeFruitJuice(juice: .strawberryJuice)
            showSuccessAlert(for: .strawberryJuice)
            
        case JuiceMaker.Menu.bananaJuice.menuNumber:
            juiceMaker.makeFruitJuice(juice: .bananaJuice)
            showSuccessAlert(for: .bananaJuice)
            
        case JuiceMaker.Menu.pineappleJuice.menuNumber:
            juiceMaker.makeFruitJuice(juice: .pineappleJuice)
            showSuccessAlert(for: .pineappleJuice)
            
        case JuiceMaker.Menu.kiwiJuice.menuNumber:
            juiceMaker.makeFruitJuice(juice: .kiwiJuice)
            showSuccessAlert(for: .kiwiJuice)
            
        case JuiceMaker.Menu.mangoJuice.menuNumber:
            juiceMaker.makeFruitJuice(juice: .mangoJuice)
            showSuccessAlert(for: .mangoJuice)
            
        case JuiceMaker.Menu.strawberryBananaJuice.menuNumber:
            juiceMaker.makeFruitJuice(juice: .strawberryBananaJuice)
            showSuccessAlert(for: .strawberryBananaJuice)
            
        case JuiceMaker.Menu.mangoKiwiJuice.menuNumber:
            juiceMaker.makeFruitJuice(juice: .mangoKiwiJuice)
            showSuccessAlert(for: .mangoKiwiJuice)
            
        default:
            print("그런 메뉴/버튼 없읍니다! 디폴트로 어떤 값을 주면 좋을까요?")
        }
    }
```
> ***from Reviewer***
> 이렇게 한 곳에서 처리하는 것이 좋습니다. 주스가 추가되면 저 함수가 계속 추가될 것이기 때문입니다. 이곳에서 스위치 문을 사용하는 것은 너무 반복되는 것 같은데요. sender.tag 를 사용해서 switch문 없이 주스가 만들어지게 개선해 볼 수 있을 것 같습니다.

<br>


- 과일쥬스 주문 버튼에 액션을 줄 때, 메서드 이름을 `orderBananaJuice`와 같이 네이밍 해주었는데, `bananaButtonTapped`와 같은 방식으로 네이밍하는 방법도 있을 것 같아요.
알맞은 네이밍인지 궁금합니다.

    > ***from Reviewer***
    > 동사로 시작해서 tapBananaJuiceButton 과 같은 메소드명이 좋다고 생각합니다!

<br>

- postNotification 메서드의 파라미터중 stock을 Optional 타입으로 주고싶은데 warning이 나와요

    - 만약 stock의 타입을 optional이 아닌 일반 Int타입으로 선언하면 주문실패 노티피케이션을 보낼 때 stock 파라미터에 의미없는 값을 보내야해서 고민입니다
    - 현재는 의미없는 값을 보내고, notification을 받는 쪽에서 받은 정보를 무시하는 식으로 코드를 작성했는데, stock를 optional 타입으로 바꾸는 방향으로 어떻게 작성하면 좋을까요?
```swift
private func postNotification(for fruit: Fruit, stock: Int?, succeed: Bool) {
        notificationCenter.post(name: Notification.Name.stockInformation,
                                object: nil,
                                userInfo: [NotificationKey.fruit: fruit,
                                           NotificationKey.stock: stock,
                                           NotificationKey.orderComplete: succeed])
}
// 위 메서드는 notification의 userInfo에 과일, 재고, 주문성공 여부를 추가정보로 제공하는 메서드 입니다.
```
![](https://i.imgur.com/PeCiE5r.png)


- optional 타입으로 주려는 이유
    
```swift
// 재고부족시 stock 정보를 줄 필요가 없어서 nil로 주고싶어요
private func hasEnoughStock(of fruit: Fruit, amount: Int) -> Bool {
        if let fruitAmount = stockOfFruit[fruit], fruitAmount >= amount {
            return true
        } else {
            postNotification(for: fruit, stock: nil, succeed: false) // false
            return false
    }
}

// 재고를 빼는것에 성공했을때는 stock 파라미터에 남은 재고를 넣어줍니다
private func subtractStock(of fruit: Fruit, amount: Int) {
    if let stock = stockOfFruit[fruit] {
        stockOfFruit[fruit] = stock - amount
        postNotification(for: fruit, stock: stock - amount, succeed: true) // true
    }
}
```

- `ViewController`class 내부의 프로퍼티나 메서드에도 접근제어를 설정해주는지 궁금합니다.

    > ***from Reviewer***
    > 좋은 질문입니다! 뷰컨트롤러 내부의 프로퍼티나 메소드에도 똑같이 접근제어를 설정해줍니다.


## 🥭 2-4. 브랜치 전략

![](https://i.imgur.com/DaPGdFV.jpg)

## 구현한 모습

![](https://i.imgur.com/cVcTaed.gif)

<br>

## Step 3. 재고 수정 기능구현

### 🍓 3-1. 구현내용
- 화면 제목 `재고추가` 및 `닫기` 버튼 구현
- 재고 수정 화면 진입시 과일의 현재 수량 표시
- `stepper`를 이용한 수량 조절 기능 구현

### 🍌 3-2. 고민했던 점
- **모델 - 뷰 컨트롤러 간 데이터 전달 방법**에 대해서 배웠습니다. 그 중에는 Notification Center, Singleton, Property Observer, KVO 등이 있었는데요. 처음에는 싱글턴으로 모든 곳에서 같은 값을 수정할 수 있도록 구현하면 편하지 않을까? 하는 생각이 있었습니다. 그러나 아래의 글을 읽고 싱글턴을 자제하자는 쪽으로 기울었습니다.(TDD를 생각하면, 테스트가 어렵다는 단점도 있을 것 같습니다.)

    > *싱글턴은 안티패턴이다?* 하나의 데이터에 접근해야 할때 싱글턴을 사용할 수 있지만, 결합도가 높아지고, 객체지향적인 구현 방식이 아니라는 단점이 있다는 점에서 싱글턴을 사용하는 것이 적절한지 고민이 되었습니다. 결론적으로는 위와같은 이유로 이번 프로젝트에서는 싱글턴을 사용하지 않았습니다!

- 따라서 NotificationCenter를 사용해서 데이터를 주고 받고 있는데, 하나 걱정되는 점은 프로젝트에서 두 개의 Notification을 사용하고 있다는 점입니다.
    1. FruitStore(모델)의 값이 변할 때 ViewController로 노티피케이션 포스트
    2. 두번째 뷰가 dismiss 될 때 노티피케이션을 포스트 & 메인뷰와 모델이 받은 노티피케이션에 대응 해주고 있습니다. 
    - 1번은 적절하게 사용했다는 생각이 드는데, 2번은 view ➡️ view, view ➡️ model 이렇게 데이터를 주는 방법이 적절한지 잘 모르겠습니다. (두번째 `view ➡️ model` 이 데이터를 주고받은 후, 메인 뷰컨트롤러가 모델에게 데이터를 받는게 맞지 않나 하는 생각이 들었습니다.) 뭔가 Notification을 남용하지 않았나? 하는 의문이 들었습니다.

    > ***from Reviewer***
    > 이 정도 노티피케이션은 필요한 부분에 쓰이고 있다고 생각합니다~



### 🍍 3-3. Trouble Shooting
- 재고수정 화면으로 넘어가는 부분을 작성한 아래의 코드에서, `navigationController`를 상수에 담아서 띄워주는 방법과, `navigationController identifier`에 재고수정 뷰컨트롤러를 넣어주는 방법 중에 어떤 방법이 더 적절한지 고민이 되었습니다.
    ```swift=
    private func showStockUpdateView() {
            if let stockUpdateController = self.storyboard?.instantiateViewController(withIdentifier: "StockUpdateController") as? StockUpdateController {
                stockUpdateController.stockOfFruit = juiceMaker.stockOfFruit
                let navigationController = UINavigationController(rootViewController: stockUpdateController)
                present(navigationController, animated: true)
            }
        }
    ```

<br>

- `StockUpdateController`에서 `updateFruitStock()` 메서드는 stepper의 value를 과일의 재고 값으로 업데이트 해주는 역할을 하고 있어요. 지금은 아래와 같이 작성해주었는데,
    ```swift=
    stockOfFruit[.strawberry] = Int(strawberryStepper.value)
    ```
    이런식으로 `updateValue`메서드를 이용해서 작성해줄 수도 있을 것 같아요. 하지만, stepper의 value를 Int로 감싸서 넣어줘야하는 부분에서 현재의 방법보다 더 나은 것인지 잘 모르겠습니다..!
    ```swift=
    stockOfFruit.updateValue(Int(strawberryStepper.value),
                             forKey: .strawberry)
    ```
    > ***from Reviewer***
    > updateValue 메소드를 만들어서 사용하면 가독성이 좋아질 것 같습니다. String으로 받아서 Int로 변환은 updateValue 메소드 안에서 하게 하면 인자에서 Int 로 안 감싸도 되지 않을까요? ㅎㅎ

<br>

### 반복되는 코드를 줄이는 방법
> ***from Reviewer***
> 스위치문을 없애는 쪽으로 수정해보세요.
```swift
switch fruit {
case .strawberry:
    strawberryLabel.text = String(stock) // 반복
case .banana:
    bananaLabel.text = String(stock) // 반복
case .pineapple:
    pineappleLabel.text = String(stock) // 반복
case .kiwi:
    kiwiLabel.text = String(stock) // 반복
case .mango:
    mangoLabel.text = String(stock) // 반복
 }
```

`레이블.text = String(stock)` 이부분이 반복되고 있다
위 코드에서 어떻게 하면 스위치문을 없앨 수 있을까?

스토리보드와 연결된 아울렛들을 그냥 배열에 담으면 이런 오류가 난다.
![https://s3.ap-northeast-2.amazonaws.com/media.yagom-academy.kr/resources/6152efbaccd9ef11a51aee4f/61851eb3a8de9c225ae0af87.png](https://s3.ap-northeast-2.amazonaws.com/media.yagom-academy.kr/resources/6152efbaccd9ef11a51aee4f/61851eb3a8de9c225ae0af87.png)

대신 Outlet Collection으로 연결하는 방법이 있다
![https://s3.ap-northeast-2.amazonaws.com/media.yagom-academy.kr/resources/6152efbaccd9ef11a51aee4f/6185283ba8de9c225ae0af8b.png](https://s3.ap-northeast-2.amazonaws.com/media.yagom-academy.kr/resources/6152efbaccd9ef11a51aee4f/6185283ba8de9c225ae0af8b.png)

### 수정 후
```swift
@IBOutlet var stockLabels: [UILabel]! // 레이블의 배열

private func updateFruitLabel(for fruit: Fruit, stock: Int) {
        for label in stockLabels {
            if label.tag == fruit.rawValue {
                label.text = String(stock)
        }
    }
 }
```
➡️ 따라서 레이블들의 배열을 만들고 for문을 돌면서 각 레이블의 텍스트를 넣어주는 식으로 수정할 수 있었다. 이렇게 수정했더니 코드수도 줄고 가독성도 높아진 것 같다.

<br>

- 스위치문을 없애라고 하신 이유
> ***from Reviewer***
> 생활코딩이라는 교육사이트에서도 자주 나오는 말인데요.
이 과일의 숫자, 주스의 종류가 100개, 1억개가 된다고 하면 어떨까요?
스위치문도 그에 따라 늘어나야할 것입니다.

- 과일의 종류나 쥬스의 종류가 늘어나는 경우 
    - 늘어난 수 만큼 코드가 반복된다 
    - 케이스를 추가해줘야 하는 번거로움이 있다
    - 가독성이 떨어진다

➡️ 위와 같은 단점이 있다. 따라서 스위치문을 사용하기 전에 케이스가 추가되는 상황이 있는지 생각해보고 사용해야 한다.


<br>

### 🥭 3-4. 브랜치 전략
![](https://i.imgur.com/IRhwN4I.jpg)


