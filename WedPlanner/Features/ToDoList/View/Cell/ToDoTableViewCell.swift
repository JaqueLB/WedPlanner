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
        return label
    }()

    private lazy var itemStatus: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        return button
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
        addSubview(itemStatus)

        subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })

        itemTitle.autoresizesSubviews = true

        NSLayoutConstraint.activate([
            itemTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor),

            itemStatus.leadingAnchor.constraint(equalTo: itemTitle.trailingAnchor, constant: 32),
            itemStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            itemStatus.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
