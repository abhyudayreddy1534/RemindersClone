//
//  CustomOperator.swift
//  RemindersClone
//
//  Created by Sravanthi Chinthireddy on 07/05/24.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: {lhs.wrappedValue ?? rhs},
        set: {lhs.wrappedValue = $0}
    )
}
