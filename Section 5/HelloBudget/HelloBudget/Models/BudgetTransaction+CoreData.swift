//
//  Transaction+CoreData.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import CoreData

@objc(BudgetTransaction)
public class BudgetTransaction: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
