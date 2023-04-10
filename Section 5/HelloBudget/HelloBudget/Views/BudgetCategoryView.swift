//
//  BudgetCategoryView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import SwiftUI

struct BudgetCategoryView: View {
    
    let category: BudgetCategory
    
    var body: some View {
        VStack {
            Text(category.title ?? "")
                .font(.largeTitle)
            
            HStack {
                Text("Budget:")
                Text(category.total as NSNumber, formatter: NumberFormatter.currency)
            }
            .fontWeight(.bold)
            
            Spacer()
        }
    }
}

struct BudgetCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCategoryView(category: PreviewData.someCategory)
    }
}
