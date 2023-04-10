//
//  BudgetCategoryListView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import SwiftUI

struct BudgetCategoryListView: View {
    
    let categories: FetchedResults<BudgetCategory>
    
    let onDelete: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            if categories.isEmpty {
                Text("List is empty")
            } else {
                ForEach(categories) { category in
                    HStack {
                        Text(category.title ?? "")
                        
                        Spacer()
                        
                        Text(category.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        onDelete(categories[index])
                    }
                }
            }
        }
    }
}
