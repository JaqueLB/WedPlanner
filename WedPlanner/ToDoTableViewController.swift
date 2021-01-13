//
//  ToDoTableViewController.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    private var viewModel = ToDoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigation()

        viewModel.refreshData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func setupNavigation() {
        navigationItem.title = "To Do"
        let addItemButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addItemButtonTapped))
        navigationItem.rightBarButtonItems = [addItemButton]

        // customize tab bar only on this controller, we do not want the back button to show the previous page title
//        self.navigationItem.titleView = UIImageView(image: UIImage(named: "dog"))
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
//        self.navigationController?.hidesBarsOnSwipe = true
    }

    @objc func addItemButtonTapped() {
        let controller = UINavigationController(rootViewController: AddItemViewController())
        present(controller, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as! ToDoTableViewCell
        cell.populate(viewModel.cellForRow(at: indexPath))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
