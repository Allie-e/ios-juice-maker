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
    }
    
    func showDefaultStock() {
        if let stock = fruitStore.stockOfFruit[.strawberry] {
            strawberryLabel.text = String(stock)
        }
        if let stock = fruitStore.stockOfFruit[.banana] {
            bananaLabel.text = String(stock)
        }
        if let stock = fruitStore.stockOfFruit[.pineapple] {
            pineappleLabel.text = String(stock)
        }
        if let stock = fruitStore.stockOfFruit[.kiwi] {
            kiwiLabel.text = String(stock)
        }
        if let stock = fruitStore.stockOfFruit[.mango] {
            mangoLabel.text = String(stock)
        }
    }
    
    @IBAction func orderStrawberryJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .strawberryJuice)
        
    }
    
    @IBAction func orderBananaJuice(_ sender: UIButton) {
        juiceMaker.makeFruitJuice(juice: .bananaJuice)
    }
    
    @IBAction func orderStrawberryBananaJuice(_ sender: UIButton) {
    }
    
    @IBAction func mangoButton(_ sender: UIButton) {
        let someAlert = UIAlertController(title: "알람이다", message: "만들었다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        someAlert.addAction(okAction)
        someAlert.addAction(cancelAction)
        
        present(someAlert, animated: true)
        
    }
}

