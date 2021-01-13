//
//  DoneTableViewController.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 07/01/21.
//

import UIKit

class DoneTableViewController: UITableViewController {
    private var viewModel = DoneViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupNavigation()
        setupTableView()
        setupViewModel()
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
}
