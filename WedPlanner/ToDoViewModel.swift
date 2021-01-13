//
//  ToDoViewModel.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import Foundation

class ToDoViewModel {
    var items = [ListItem]()

    func cellForRow(at indexPath: IndexPath) -> ListItem {
        return items[indexPath.row]
    }

    func numberOfRows(_ section: Int) -> Int {
        return items.count
    }
}
