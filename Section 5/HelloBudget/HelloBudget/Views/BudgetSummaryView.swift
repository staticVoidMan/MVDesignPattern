//
//  BudgetSummaryView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 11/04/23.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    @ObservedObject var category: BudgetCategory
    
    var body: some View {
        HStack {
            Text(category.hasOverspent ? "Overspent" : "Remaining")
            Text(category.remainingTotal as NSNumber, formatter: NumberFormatter.currency)
        }
        .foregroundColor(category.hasOverspent ? .red : .green)
        .fontWeight(.bold)
    }
}

struct BudgetSummaryView_Previews: PreviewProvider {
    
    static var category: BudgetCategory {
        let category = PreviewData.someCategory
        let transaction = PreviewData.someTransaction
        category.addToTransactions(transaction)
        return category
    }
    
    static var previews: some View {
        BudgetSummaryView(category: category)
            .previewLayout(.sizeThatFits)
    }
}
