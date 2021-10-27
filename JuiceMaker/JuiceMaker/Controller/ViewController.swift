//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    let juiceMaker = JuiceMaker()
    let fruitStore = FruitStore()
    
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDefaultStock()
        addObserver()
        addOutOfStockObserver()
    }
    
    func showDefaultStock() {
            strawberryLabel.text = "10"
            bananaLabel.text = "10"
            pineappleLabel.text = "10"
            kiwiLabel.text = "10"
            mangoLabel.text = "10"
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeStock(notification:)), name: Notification.Name.changeOfStock, object: nil)
    }
    
    func addOutOfStockObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(noMoreStock(notification:)), name: Notification.Name.outOfStock, object: nil)
    }
    
    @objc func changeStock(notification: Notification) {
        if let fruit = notification.userInfo?["fruit"] as? Fruit,
           let stock = notification.userInfo?["stock"] as? Int {
            updateFruitLabel(of: fruit, to: stock)
        }
    }
    @objc func noMoreStock(notification: Notification) {
//        if let fruit = notification.userInfo?["fruit"] as? Fruit,
//           let stock = notification.userInfo?["stock"] as? Int {
//            outOfStockAlert()
//        }
        outOfStockAlert()
    }
    func updateFruitLabel(of name: Fruit, to stock: Int) {
        switch name {
        case .strawberry:
            strawberryLabel.text = String(stock)
        case .banana:
            bananaLabel.text = String(stock)
        case .pineapple:
            pineappleLabel.text = String(stock)
        case .kiwi:
            kiwiLabel.text = String(stock)
        case .mango:
            mangoLabel.text = String(stock)
        }
    }
    
    @IBAction func orderStrawberryJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .strawberryJuice)
        completeOrderAlert()
    }
    
    @IBAction func orderBananaJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .bananaJuice)
        completeOrderAlert()
    }
    
    @IBAction func orderStrawberryBananaJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .strawberryBananaJuice)
        completeOrderAlert()
    }
    
    @IBAction func orderPineappleJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .pineappleJuice)
        completeOrderAlert()
    }
    
    @IBAction func orderKiwiJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .kiwiJuice)
        completeOrderAlert()
    }
    
    @IBAction func orderMangoKiwiJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .mangoKiwiJuice)
        completeOrderAlert()
    }
    @IBAction func orderMangoJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .mangoJuice)
        completeOrderAlert()
    }

    func completeOrderAlert() {
        let completionAlert = UIAlertController(title: nil, message: "쥬스 나왔습니다! 맛있게 드세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)

        completionAlert.addAction(okAction)
        present(completionAlert, animated: true)
    }
    
    func outOfStockAlert() {
        let outOfStock = UIAlertController(title: nil, message: "재료가 모자라요. 재고를 수정할까요?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .default)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel)
        
        outOfStock.addAction(okAction)
        outOfStock.addAction(cancelAction)
        present(outOfStock, animated: true)
    }
    
}

