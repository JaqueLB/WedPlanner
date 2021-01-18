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
            guard let storedObjItem = UserDefaults.standard.object(forKey: "list") as? Data else { return }
            let storedItems = try JSONDecoder().decode([ListItem].self, from: storedObjItem)
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

    func markItemDone(at indexPath: IndexPath) -> Void {
        var item = cellForRow(at: indexPath)
        item.isComplete = !item.isComplete

        let storedItems = getStoredItems()
        var items = storedItems.filter { $0.id != item.id }
        items.append(item)
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "list")
        }
        refreshData?()
        populate()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewDoneItem"), object: self)
    }

    func getStoredItems() -> [ListItem] {
        do {
            guard let storedObjItem = UserDefaults.standard.object(forKey: "list") as? Data else { return [ListItem]() }
            return try JSONDecoder().decode([ListItem].self, from: storedObjItem)
        } catch let err {
            print(err)
            return [ListItem]()
        }
    }

    func save(item: ListItem) {
        var storedItems = getStoredItems()
        storedItems.append(item)
        if let encoded = try? JSONEncoder().encode(storedItems) {
            UserDefaults.standard.set(encoded, forKey: "list")
        }
        refreshData?()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewItem"), object: self)
    }
}
