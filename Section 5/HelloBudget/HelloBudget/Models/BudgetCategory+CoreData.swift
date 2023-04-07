//
//  BudgetCategory+CoreData.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 07/04/23.
//

import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
