//
//  AddBudgetCategoryView.swift
//  HelloBudget
//
//  Created by Amin Siddiqui on 10/04/23.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    let category: BudgetCategory?
    
    @State private var title: String = ""
    @State private var total: Double = 50
    
    @State private var errors: [String] = []
    @State private var titleError: String = ""
    @State private var totalError: String = ""
    
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        errors = []
        
        if title.isEmpty {
            errors.append("Title required")
        }
        
        if total <= 0 {
            errors.append("Budget amount must be > 0")
        }
        
        return errors.isEmpty
    }
    
    init(category: BudgetCategory? = nil) {
        self.category = category
    }
    
    private func save() {
        let category = category ?? BudgetCategory(context: context)
        category.title = title
        category.total = total
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                Slider(value: $total, in: 0...500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("$0")
                } maximumValueLabel: {
                    Text("$500")
                }
                
                Text(total as NSNumber,
                     formatter: NumberFormatter.currency)
                .frame(maxWidth: .infinity)
                
                ForEach(errors, id: \.self) { error in
                    Text(error)
                }
            }
            .onAppear {
                if let category {
                    title = category.title ?? ""
                    total = category.total
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            save()
                        }
                    }
                }
            }
        }
    }
}

struct AddBudgetCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetCategoryView()
    }
}
