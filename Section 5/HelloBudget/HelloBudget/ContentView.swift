//
//  ContentView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 07/04/23.
//

import SwiftUI

struct ContentView: View {
    
    enum ActionContext: Identifiable {
        var id: UUID {
            UUID()
        }
        
        case add
        case edit(category: BudgetCategory)
    }
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(fetchRequest: BudgetCategory.all) private var categories
    
    @State private var actionContext: ActionContext?
    
    private var grandTotal: Double {
        categories.reduce(0) { $0 + $1.total }
    }
    
    private func deleteCategory(_ category: BudgetCategory) {
        context.delete(category)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func editCategory(_ category: BudgetCategory) {
        actionContext = .edit(category: category)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Total Budget:")
                    Text(
                        grandTotal as NSNumber,
                        formatter: NumberFormatter.currency
                    )
                    .fontWeight(.bold)
                }
                
                BudgetCategoryListView(
                    categories: categories,
                    onDelete: deleteCategory,
                    onEdit: editCategory
                )
                .sheet(item: $actionContext) { action in
                    switch action {
                    case .add:
                        AddBudgetCategoryView()
                    case let .edit(category):
                        AddBudgetCategoryView(category: category)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add new category") {
                            actionContext = .add
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.context)
    }
}
