//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    let juiceMaker = JuiceMaker()
    
    
    @IBOutlet private weak var strawberryLabel: UILabel!
    @IBOutlet private weak var bananaLabel: UILabel!
    @IBOutlet private weak var pineappleLabel: UILabel!
    @IBOutlet private weak var kiwiLabel: UILabel!
    @IBOutlet private weak var mangoLabel: UILabel!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserverForStockUpdate()
        showInitialStock()
        addNewObserver()
    }
    
    private func addObserverForStockUpdate() {
        notificationCenter.addObserver(self,
                                       selector: #selector(didReceiveNotification),
                                       name: Notification.Name.stockInformation,
                                       object: nil)
    }
    
    func addNewObserver() {
        notificationCenter.addObserver(self,
                                       selector: #selector(didReceiveInfo),
                                       name: Notification.Name.new,
                                       object: nil)
    }

    @objc func didReceiveInfo() {
        let stockOfFruit = juiceMaker.stockOfFruit
        
        for (fruit, stock) in stockOfFruit {
            updateFruitLabel(for: fruit, stock: stock)
        }
    }
    
    private func showInitialStock() {
        let stockOfFruit: [Fruit: Int] = juiceMaker.stockOfFruit
        
        for (fruit, stock) in stockOfFruit {
            updateFruitLabel(for: fruit, stock: stock)
        }
    }
    
  
     func updateFruitLabel(for fruit: Fruit, stock: Int) {
        
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
    
    @objc private func didReceiveNotification(_ notification: Notification) {
        let userInfo = notification.userInfo
        
        if let fruit = userInfo?[NotificationKey.fruit] as? Fruit,
           let stock = userInfo?[NotificationKey.stock] as? Int,
           let orderComplete = userInfo?[NotificationKey.orderComplete] as? Bool {
            
            
            if orderComplete {
                updateFruitLabel(for: fruit, stock: stock)
                return
            }
            showOrderFailAlert(fruit: fruit)
        }
    }
    
    @IBAction func showSecondViewController(_ sender: UIBarButtonItem) {
        show()
    }
    
    
    func show() {
        let stockController = self.storyboard?.instantiateViewController(withIdentifier: "StockUpdateController") as? StockUpdateController
        stockController?.stockOfFruit = juiceMaker.stockOfFruit
        
        let nav = UINavigationController(rootViewController: stockController!)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    @IBAction private func tapJuiceOrderButton(_ sender: UIButton) {
        do {
            guard let menu = JuiceMaker.Menu(rawValue: sender.tag) else {
                throw JuiceMakerError.invalidTagNumberForButton
            }
            makeJuice(for: menu)
        } catch JuiceMakerError.invalidTagNumberForButton {
            print(JuiceMakerError.invalidTagNumberForButton.description)
        } catch {
            print(error)
        }
    }
    
    @IBAction func moveToStockUpdateView(_ sender: UIBarButtonItem) {
        showStockUpdateView()
    }
    
    private func makeJuice(for menu: JuiceMaker.Menu) {
        juiceMaker.makeFruitJuice(juice: menu)
        showOrderSuccessAlert(for: menu)
    }
    
    private func showOrderSuccessAlert(for menu: JuiceMaker.Menu) {
        let message = menu.description + AlertMessage.orderComplete
        let okAction = UIAlertAction(title: AlertMessage.ok, style: .default)
        let OrderSuccessAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        OrderSuccessAlert.addAction(okAction)
        present(OrderSuccessAlert, animated: true, completion: nil)
    }
    
    private func showOrderFailAlert(fruit: Fruit) {
        let message = fruit.description + AlertMessage.outOfStock
        let cancelAction = UIAlertAction(title:AlertMessage.cancel, style: .cancel)
        let okAction = UIAlertAction(title: AlertMessage.ok, style: .default) { _ in
<<<<<<< HEAD
            self.showStockUpdateView()
=======
            self.show()
>>>>>>> f5ab48408034dcecacfa0edc73c41a6dcb748842
        }
        let orderFailAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        orderFailAlert.addAction(okAction)
        orderFailAlert.addAction(cancelAction)
        present(orderFailAlert, animated: true, completion: nil)
    }
    
    private func showStockUpdateView() {
        if let stockUpdateController = self.storyboard?.instantiateViewController(withIdentifier: "StockUpdateController") as? StockUpdateController {
            stockUpdateController.stockOfFruit = juiceMaker.stockOfFruit
            let navigationController = UINavigationController(rootViewController: stockUpdateController)
            present(navigationController, animated: true)
        }
    }
}

