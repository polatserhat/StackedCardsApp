//
//  Item.swift
//  StackedCardsApp
//
//  Created by Serhat  on 20.05.24.
//

import SwiftUI

struct Item: Identifiable {
    var id: UUID = .init()
    var color: Color
}

var items: [Item] = [
    .init(color: .blue),
    .init(color: .green),
    .init(color: .red),
    .init(color: .purple),
    .init(color: .yellow),
    .init(color: .pink),
]

