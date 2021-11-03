//
//  StockUpdateController.swift
//  JuiceMaker
//
//  Created by 권나영 on 2021/10/28.
//

import UIKit

class StockUpdateController: UIViewController {
    
    
    
    

    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    
    
    var stockOfFruit: [Fruit: Int]  = [Fruit: Int]()
    
    // property observer
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStock()
    }
 
    
    
    
    func setStock() {
        
        stockOfFruit.forEach({ (fruit, stock) in
            switch fruit {
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
        })
    }
    
    
    private func updateFruitLabel(for fruit: Fruit, stock: Int) {

        switch fruit {
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
  
   
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
