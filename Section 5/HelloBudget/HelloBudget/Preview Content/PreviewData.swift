//
//  PreviewData.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import Foundation

struct PreviewData {
    
    static var someCategory: BudgetCategory {
        let category = BudgetCategory(context: CoreDataProvider.shared.context)
        category.title = "Some Category"
        category.total = 100
        return category
    }
    
    static var someTransaction: BudgetTransaction {
        let transaction = BudgetTransaction(context: CoreDataProvider.shared.context)
        transaction.title = "Some Transaction"
        transaction.total = 10
        return transaction
    }
}
