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
        category.title = "Some Title"
        category.total = 100
        return category
    }
}
