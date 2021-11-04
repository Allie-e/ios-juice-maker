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
    
    
    var stockOfFruit: [Fruit: Int]  = [:]
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStock()
        navigationController?.title = "앨리 조이의 쥬스가게"
    }
 
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    
    
    func updateModel() {
        stockOfFruit[.strawberry] = Int(strawberryStepper.value)
        stockOfFruit[.banana] = Int(bananaStepper.value)
        stockOfFruit[.pineapple] = Int(pineappleStepper.value)
        stockOfFruit[.kiwi] = Int(kiwiStepper.value)
        stockOfFruit[.mango] = Int(mangoStepper.value)
    }
    
    func setStock() {
        stockOfFruit.forEach({ (fruit, stock) in
            switch fruit {
            case .strawberry:
                strawberryLabel.text = String(stock)
                strawberryStepper.value = Double(stock)
                
            case .banana:
                bananaLabel.text = String(stock)
                bananaStepper.value = Double(stock)
                
            case .pineapple:
                pineappleLabel.text = String(stock)
                pineappleStepper.value = Double(stock)
                
            case .kiwi:
                kiwiLabel.text = String(stock)
                kiwiStepper.value = Double(stock)
                
            case .mango:
                mangoLabel.text = String(stock)
                mangoStepper.value = Double(stock)
            }
        })
    }
    
    
  
    @IBAction func tapStrawberryStepper(_ sender: UIStepper) {
        do {
            guard let fruit = Fruit(rawValue: sender.tag) else {
                throw JuiceMakerError.invalidTagNumberForButton
            }
            let intValue = Int(sender.value)
            
            a(fruit: fruit, value: intValue)
        } catch JuiceMakerError.invalidTagNumberForButton {
            print(JuiceMakerError.invalidTagNumberForButton.description)
        } catch {
            print(error)
        }
    }
    
    func a(fruit: Fruit, value: Int) {
        switch fruit {
        case .strawberry:
            strawberryLabel.text = String(value)
            
        case .banana:
            bananaLabel.text = String(value)
            
        case .pineapple:
            pineappleLabel.text = String(value)
            
        case .kiwi:
            kiwiLabel.text = String(value)
            
        case .mango:
            mangoLabel.text = String(value)
        }
    }
    
    /// ~~~앨리~~~~~~~~~~~~~~
    /// 앨리~~~print(#fileID, #function, #line)
    @IBAction func  back(_ sender: UIBarButtonItem) {
        updateModel()
        
        notificationCenter.post(name: Notification.Name.new, object: nil, userInfo: ["new": self.stockOfFruit])
        
        dismiss(animated: true)
    }
    
    // 세그와 present의 차이
    // performSegue -> 야곰의 의도에 더 적절하다
}
