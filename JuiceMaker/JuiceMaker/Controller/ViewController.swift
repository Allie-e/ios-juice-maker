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
        // Do any additional setup after loading the view.
    }


    @IBAction func orderStrawberryJuice(_ sender: UIButton) {
        if let stock = fruitStore.stockOfFruit[.strawberry] {
            strawberryLabel.text = String(stock)
        }
        juiceMaker.makeFruitJuice(juice: .strawberryJuice)
        
    }
    
//     @IBAction func orderBananaJuice(_ sender: UIButton) {
//        juiceMaker.makeFruitJuice(juice: .bananaJuice)
//    }
    
    
}

