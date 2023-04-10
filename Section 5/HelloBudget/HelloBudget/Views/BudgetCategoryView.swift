//
//  BudgetCategoryView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import SwiftUI

struct BudgetCategoryView: View {
    
    let category: BudgetCategory
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var title: String = ""
    @State private var amount: String = ""
    
    private var isFormValid: Bool {
        guard let amount = Double(amount) else { return false }
        return !title.isEmpty && (amount > 0)
    }
    
    private func saveTransaction() {
        let transaction = BudgetTransaction(context: context)
        transaction.title = title
        transaction.total = Double(amount)!
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
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
            
            Form {
                Section("Add Transaction") {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                }
                
                Button("Save") {
                    print(#function)
                }
                .frame(maxWidth: .infinity)
                .disabled(!isFormValid)
            }
        }
    }
}

struct BudgetCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCategoryView(category: PreviewData.someCategory)
    }
}
