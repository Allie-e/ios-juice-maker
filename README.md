# STEP 1. 쥬스메이커 타입 정의

## 목차
  * [기간](#기간)
  * [타임라인](#타임라인)
  * [구현 내용](#구현-내용)
  * [고민했던 점](#고민했던-점)
  * [궁금한 점 / 개선한 부분](#궁금한-점-개선한-부분)
  * [브랜치 전략](#브랜치-전략)
  * [학습 키워드](#학습-키워드)

### 기간
2021.10.18(월) - 2021.10.22(금)

### 타임라인
- 월: 학습활동, 그라운드룰 작성, 개인공부(앨리-구조체, 클래스 / 조이-이니셜라이저)
- 화: nest type과 프로퍼티에 대한 학습 / 조이 - 대략적인 프로젝트 구상
- 수: 기획서 분석 / 과일의 수량을 조절하고 음료를 주문하는 기능 구현 + 개인공부
- 목: 학습활동 / pr 제출
- 금: 코드 수정 후 머지


### 구현 내용

- 과일의 재고를 관리하는 FruitStore 클래스 / 과일의 종류를 나타내는 Fruit 열거형 
- 과일쥬스를 제조하는 JuiceMaker 구조체 / 쥬스 메뉴를 나타내는 Menu 열거형 / 과일 소비량을 관리할 Recipe(name space)
- 프로젝트내에서 일어나는 모든 오류를 관리할 JuiceMakerError

### 고민했던 점

매직넘버 사용 지양
- 과일을 소비할 때 과일쥬스의 레시피를 하드코딩하지 않고 열거형으로 정리했습니다
- 매직넘버 사용을 지양하고자 Recipe 열거형에 과일 소비량의 namespace를 만들어 관리합니다

에러타입 정의
- 본 프로젝트에서 나올 수 있는 모든 에러들을 JuiceMakerError 열거형에 정의했습니다
- 또 description으로 에러메세지를 관리하고 있습니다

코드 컨벤션 준수
- 같은 성격의 변수라는것을 파악하기 쉽게 하기 위해 변수를 유사한 이름으로 맞췄습니다

<br>

## 궁금한 점 개선한 부분
1. 의미없는 return을 지향하는것  
어래 코드에서 guard 문의 파라미터를 enum으로 받고있어서 else 블럭이 실행될 일이 없다고 판단되는데,  
이런 경우에도 의미없는 리턴을 해주는 건 지양해야 할까요?

```swift
func subtractStock(of fruit: Fruit, amount: Int) {
        guard let stock = stockOfFruit[fruit] else { return } // 이 부분
        stockOfFruit[fruit] = stock - amount
    }
```

> 나중에 fruit 에 과일 목록에 없는 값을 넣으면 프로그램이 강제 종료될 수 있을 것 같습니다.  
> 항상 optional 을 바인딩할 때는 if let, guard let 을 활용해주는 것이 좋습니다.

의미없는 리턴은 지양해야한다는걸 다시 한 번 알게되었습니다.  
consumeStock 메서드에서 `guard let`을 -> `if let` 으로 바꿔주었어요!

<br>

2. 개행의 의의  
코드를 작성할 때, 개행에도 의미가 있어야한다고 하는데,  
`가독성 측면에서 개행하는 것` vs `의미를 생각해서 개행하지 않는 것` 중 어떤 방법을 택해야하는지 고민이 되었어요.
> 저는 풀어서 쓰는 것을 선호합니다.   
> 조금 더 익숙해지면 여러 줄의 코드를 한 줄로 동료들과 약속을 정해서 줄여볼 수 있겠지만  
> 회사에 들어가기 전까지는 길어지더라도 공식문서에 있는 형식으로 작성하는 것을 추천드립니다!

<br>

3. 네이밍 관련 고민  
네이밍은 항상 어려운 것 같아요.. 😅 아래 함수의 파라미터 네이밍이 적절한지에대해 이야기를 나누어 봤는데 다른 이름이 떠오르질 않습니다..!
```swift
func consumeTwoKindsOfFruits(first: Fruit, firstAmount: Int, second: Fruit, secondAmount: Int)
```
> 메소드의 네이밍 괜찮다고 생각했습니다. 조금 길어서 어색하게 생각하신 것 같은데요. 네이밍이 명확해지면 길이가 길어져도 괜찮습니다.

<br>

4. 에러타입이 정의하는 에러의 범위에 대해  
JuiceMakerError의 역할은 FruitStore에 있는 Error를 다루는 것인데요.  
만약 JuiceMakerError에서 프로젝트 내의 모든 오류를 다뤄준다고 하면, 오류처리를 위한 파일을 새로 만들어서 관리를 하는게 좋을까요?

> 열거형, 객체 등은 별도의 파일로 나눠주는 것이 좋습니다.

프로그램 전체에 대한 에러를 다루는 열거형이라면 따로 파일을 만들어서 관리하는것이 좋겠네요!  
도미닉이 말해주신대로 새로운 파일을 따로 만들어서 에러를 관리하기로 했습니다  
더불어 지금은 프로젝트가 크지 않아서 에러종류가 많지 않지만,  
프로젝트가 커지고 에러가 다양해지면 에러타입의 종류를 구분해줘도 될것같다는 생각을 헀어요  

<br>

### 브랜치 전략
- main: 완성된 프로젝트를 보관하는 브랜치
- develop: pr, 리뷰를 받고 개선한 코드를 보관하는 브랜치
- step1,2,3: 각 스텝의 요구사항을 구현하는 / 평소 코드를 작성하는 브랜치
![](https://i.imgur.com/sjYiHHr.jpg)



### 학습 키워드
CustomSTringConvertible  
enum - associated value  
namespace  
git flow  
MVC

# ios-juice-maker Step2

## 신경쓴 부분
재고의 값이 변경될때 마다 어떻게 뷰를 업데이트 해줄지 고민했습니다  
모델과 컨트롤러가 서로를 모를수록 좋고 + 의존성을 제거하기 위해   
인스턴스가 간접적으로 메세지를 주고 받는 방법 중 하나인 Notification 을 사용했습니다  
NotificationCenter 는 1: N 으로 소통을 할 때 적절한 방법입니다  

나중에 재고를 수정하는 뷰 컨트롤러에도 값 변경 이벤트를 전달할 필요가 있기때문에  
Notification 의 취지에도 적합하다고 생각했습니다
(저희 프로젝트의 경우 `1` = FruitStore, `N` = viewController, StockUpdateController 입니다)


## 고민했던 점, 해결방법
- `consumeFruit()` 함수에서 믹스쥬스를 제조할 때, 두가지 과일 중 한 종류의 과일이라도 재고가 부족하다면, 쥬스가 만들어지지 않도록 설계를 했습니다. 그런데, 로직의 오류로 쥬스는 만들어지지 않지만, 재고가 충분한 과일의 재고가 빠지는 오류가 발견되었고, 도미닉의 조언대로 guard문을 분리하는 방법으로 해결했습니다. **감사합니다!**
- checkStock() 함수를 Bool 타입을 반환하는 함수로 변경하면서, 네이밍을 hasEnoughStock()으로 변경했어요. `~을 가지고있는가?`의 의미를 가진다고 생각해서 수정해보았습니다.

---

## 조언을 얻고싶은 부분
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



- 과일쥬스 주문 버튼에 액션을 줄 때, 메서드 이름을 `orderBananaJuice`와 같이 네이밍 해주었는데, `bananaButtonTapped`와 같은 방식으로 네이밍하는 방법도 있을 것 같아요.
알맞은 네이밍인지 궁금합니다.

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


- optional 타입으로 주려는 이유!
    
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

- `ViewController`class 내부의 프로퍼티나 메서드에도 접근제어를 설정해주는지 궁금해요!


## 브랜치 전략

![](https://i.imgur.com/DaPGdFV.jpg)

## 구현한 모습

![](https://i.imgur.com/cVcTaed.gif)

