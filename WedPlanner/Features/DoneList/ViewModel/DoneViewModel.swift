//
//  DoneViewModel.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 13/01/21.
//

import Foundation

class DoneViewModel {
    private (set) var items = [ListItem]()

    var refreshData: (() -> Void)?

    init() {
        guard let list = UserDefaults.standard.array(forKey: "list") as? [ListItem], !list.isEmpty else { return }

        list.forEach({ item in
            if item.isComplete {
                items.append(item)
            }
        })
    }

    func cellForRow(at indexPath: IndexPath) -> ListItem {
        return items[indexPath.row]
    }

    func numberOfRows(_ section: Int) -> Int {
        return items.count
    }

    func didSelectRow(at indexPath: IndexPath) -> Void {
        var item = cellForRow(at: indexPath)
        item.isComplete = !item.isComplete
        items[indexPath.row] = item
        UserDefaults.standard.set(item, forKey: "list")
        items.remove(at: indexPath.row)
        refreshData?()
    }
}
