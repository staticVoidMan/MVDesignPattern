//
//  ConditionalView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 04/04/23.
//

import SwiftUI

struct ConditionalView<T: View, U: View>: View {
    
    @Binding var condition: Bool
    
    @ViewBuilder var then: T
    @ViewBuilder var `else`: U
    
    init(
        _ condition: Binding<Bool>,
        @ViewBuilder then: @escaping () -> T,
        @ViewBuilder `else`: @escaping () -> U
    ) {
        self._condition = condition
        self.then = then()
        self.`else` = `else`()
    }
    
    var body: some View {
        if condition {
            then
        } else {
            `else`
        }
    }
}

struct CaseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConditionalView(
                .constant(true),
                then: {
                    Text("True")
                },
                else: {
                    Text("False")
                }
            )
            .previewDisplayName("if condition is true")
            
            ConditionalView(.constant(false)) {
                Text("True")
            } else: {
                Text("False")
            }
            .previewDisplayName("if condition is false")
        }
    }
}
