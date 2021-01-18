//
//  DoneTableViewController.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 07/01/21.
//

import UIKit

class DoneTableViewController: UITableViewController {
    private lazy var viewModel = DoneViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupNavigation()
        setupTableView()
        setupViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(newDoneItem(notification:)), name: NSNotification.Name(rawValue: "NewDoneItem"), object: nil)
    }

    // MARK: setup UI
    func setupNavigation() {
        navigationItem.title = "Done"
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
    @objc func newDoneItem(notification: Notification) {
        viewModel.populate()
        viewModel.refreshData?()
    }

    // MARK: - Table view data source
    func setupTableView() {
        tableView.register(DoneTableViewCell.self, forCellReuseIdentifier: DoneTableViewCell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoneTableViewCell.reuseIdentifier, for: indexPath) as! DoneTableViewCell
        cell.populate(viewModel.cellForRow(at: indexPath))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
