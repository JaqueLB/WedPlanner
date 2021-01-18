//
//  ToDoTableViewCell.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func populate(_ listItem: ListItem) {
        itemTitle.text = listItem.title
    }

    func setupUi() {
        addSubview(itemTitle)

        itemTitle.autoresizesSubviews = true

        NSLayoutConstraint.activate([
            itemTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
