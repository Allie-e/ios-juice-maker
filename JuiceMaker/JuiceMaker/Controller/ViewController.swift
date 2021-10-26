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
    
    
}

