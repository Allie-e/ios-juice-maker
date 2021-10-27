//
//  JuiceMaker - FruitStore.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

enum Fruit: String, CaseIterable {
    case strawberry, banana, pineapple, kiwi, mango
    
    var stringValue: String {
        self.rawValue
    }
}

class FruitStore {
   var stockOfFruit: [Fruit: Int] = [:]
    
    init() {
        for fruit in Fruit.allCases {
            stockOfFruit[fruit] = 10
        }
    }
    
    private func checkStock(of fruit: Fruit, count: Int) -> Bool {
        guard let fruitAmount = stockOfFruit[fruit],
              fruitAmount >= count else {
                  postOutOfStockNotification(name: fruit, count: count)
                  return false
              }
        return true
    }
    
    func subtractStock(of fruit: Fruit, amount: Int) {
        if let stock = stockOfFruit[fruit] {
            stockOfFruit[fruit] = stock - amount
            postNotification(name: fruit, count: stock - amount)
        }
    }
    
    func consumeFruits(firstFruit: Fruit, firstFruitAmount: Int, secondFruit: Fruit? = nil, secondFruitAmount: Int? = nil) {
        guard checkStock(of: firstFruit, count: firstFruitAmount) else {
            postOutOfStockNotification(name: firstFruit, count: firstFruitAmount)
            
            return
        }
        guard let secondFruit = secondFruit,
           let secondFruitAmount = secondFruitAmount else {
               subtractStock(of: firstFruit, amount: firstFruitAmount)
               return
        }
        guard checkStock(of: secondFruit, count: secondFruitAmount) else {
            postOutOfStockNotification(name: secondFruit, count: secondFruitAmount)
            
            return
        }
       
        subtractStock(of: firstFruit, amount: firstFruitAmount)
        subtractStock(of: secondFruit, amount: secondFruitAmount)
    }
    
    func postNotification(name: Fruit, count: Int) {
        NotificationCenter.default.post(name: Notification.Name.changeOfStock,
                                        object: nil,
                                        userInfo: ["fruit": name, "stock": count])
    }
    func postOutOfStockNotification(name: Fruit, count: Int) {
        NotificationCenter.default.post(name: Notification.Name.outOfStock,
                                        object: nil,
                                        userInfo: ["fruit": name, "stock": count])
    }
}
