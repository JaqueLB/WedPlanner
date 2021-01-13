//
//  List.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import Foundation

struct ListItem: Codable {
    var id = UUID()
    var title: String
    var price: Double?
    var seller: String?
    var isComplete = false
}
