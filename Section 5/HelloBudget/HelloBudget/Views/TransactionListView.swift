//
//  TransactionListView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    
    typealias OnDeleteCompletion = (BudgetTransaction) -> Void
    
    @FetchRequest private var transactions: FetchedResults<BudgetTransaction>
    let onDelete: OnDeleteCompletion
    
    init(request: NSFetchRequest<BudgetTransaction>, onDelete: @escaping OnDeleteCompletion) {
        self._transactions = FetchRequest(fetchRequest: request)
        self.onDelete = onDelete
    }
    
    var body: some View {
        if transactions.isEmpty {
            Text("No Transactions")
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }
                .onDelete { indices in
                    indices.forEach { index in
                        onDelete(transactions[index])
                    }
                }
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(
            request: PreviewData.someCategory.allTransactionsRequest
        ) { _ in }
    }
}
