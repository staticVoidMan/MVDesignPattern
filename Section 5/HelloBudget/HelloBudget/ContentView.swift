//
//  ContentView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 07/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<BudgetCategory>
    
    @State private var isPresentingAddNewCategory: Bool = false
    
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
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(grandTotal as NSNumber, formatter: NumberFormatter.currency)
                    .font(.headline)
                
                BudgetCategoryListView(
                    categories: categories,
                    onDelete: deleteCategory
                )
                
                .sheet(isPresented: $isPresentingAddNewCategory) {
                    AddBudgetCategoryView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add new category") {
                            isPresentingAddNewCategory = true
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
