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
    
    private func resetForm() {
        title = ""
        amount = ""
    }
    
    private func saveTransaction() {
        let transaction = BudgetTransaction(context: context)
        transaction.title = title
        transaction.total = Double(amount)!
        
        category.addToTransactions(transaction)
        
        do {
            try context.save()
            resetForm()
        } catch {
            print(error)
        }
    }
    
    private func deleteTransaction(_ transaction: BudgetTransaction) {
        context.delete(transaction)
        
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
                    saveTransaction()
                }
                .frame(maxWidth: .infinity)
                .disabled(!isFormValid)
            }
            
            BudgetSummaryView(category: category)
            
            TransactionListView(
                request: category.allTransactionsRequest,
                onDelete: deleteTransaction(_:)
            )
        }
    }
}

struct BudgetCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCategoryView(category: PreviewData.someCategory)
    }
}
