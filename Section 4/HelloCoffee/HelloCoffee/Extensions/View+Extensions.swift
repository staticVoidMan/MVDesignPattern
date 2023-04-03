//
//  View+Extensions.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 03/04/23.
//

import SwiftUI

enum PlacementLocation {
    case leading
    case trailing
    case center
}

extension View {
    
    func placement(_ location: PlacementLocation) -> some View {
        return HStack {
            if location != .leading {
                Spacer()
            }
            self
            if location != .trailing {
                Spacer()
            }
        }
    }
}
