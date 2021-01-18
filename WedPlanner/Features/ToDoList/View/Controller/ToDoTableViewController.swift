//
//  ToDoTableViewController.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    private lazy var viewModel = ToDoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupNavigation()
        setupViewModel()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(newItem(notification:)), name: NSNotification.Name(rawValue: "NewItem"), object: nil)
    }

    // MARK: setup UI
    func setupNavigation() {
        navigationItem.title = "To Do"
        let addItemButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addItemButtonTapped))
        navigationItem.rightBarButtonItems = [addItemButton]

        // customize tab bar only on this controller, we do not want the back button to show the previous page title
//        self.navigationItem.titleView = UIImageView(image: UIImage(named: "dog"))
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
//        self.navigationController?.hidesBarsOnSwipe = true
    }

    func setupUi() {
        view.backgroundColor = .systemBackground
    }

    func setupViewModel() {
        viewModel.refreshData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: target methods, event-driven methods
    @objc func addItemButtonTapped() {
        let controller = UINavigationController(rootViewController: AddItemViewController())
        present(controller, animated: true, completion: nil)
    }

    @objc func newItem(notification: Notification) {
        viewModel.populate()
        viewModel.refreshData?()
    }

    // MARK: - Table view data source
    func setupTableView() {
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)
    }

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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneItem = UIContextualAction(style: .normal, title: "done") { (contextualAction, view, boolValue) in
            self.viewModel.markItemDone(at: indexPath)
        }

        doneItem.backgroundColor = .systemGray

        let swipeActions = UISwipeActionsConfiguration(actions: [doneItem])

        return swipeActions
    }
}
