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
    
    var body: some View {
        NavigationStack {
            List(categories) { category in
                Text(category.title ?? "")
            }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.context)
    }
}
