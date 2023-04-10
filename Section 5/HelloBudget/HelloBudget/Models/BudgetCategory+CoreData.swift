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
    
    public var allTransactionsRequest: NSFetchRequest<BudgetTransaction> {
        let request = BudgetTransaction.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "dateCreated", ascending: true)
        ]
        request.predicate = NSPredicate(format: "category = %@", self)
        return request
    }
}
