//
//  TransactionListView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    
    @FetchRequest private var transactions: FetchedResults<BudgetTransaction>
    
    init(request: NSFetchRequest<BudgetTransaction>) {
        self._transactions = FetchRequest(fetchRequest: request)
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
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(
            request: PreviewData.someCategory.allTransactionsRequest
        )
    }
}
