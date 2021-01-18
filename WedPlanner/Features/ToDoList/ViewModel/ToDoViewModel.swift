//
//  ToDoViewModel.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import Foundation

class ToDoViewModel {
    var items = [ListItem]()

    var refreshData: (() -> Void)?

    init() {
        populate()
    }

    func populate() {
        do {
            var list = [ListItem]()
            let storedObjItem = UserDefaults.standard.object(forKey: "list")
            let storedItems = try JSONDecoder().decode([ListItem].self, from: storedObjItem as! Data)
            storedItems.forEach({ item in
                if !item.isComplete {
                    list.append(item)
                }
            })
            items = list
        } catch let err {
            print(err)
        }
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
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "list")
            refreshData?()
        }
        items.remove(at: indexPath.row)
        refreshData?()
    }

    func save(item: ListItem) {
        items.append(item)
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "list")
        }
        refreshData?()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewItem"), object: self)
    }
}
