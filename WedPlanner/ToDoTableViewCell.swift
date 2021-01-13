//
//  ToDoTableViewCell.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    var itemTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        return label
    }()

    var itemStatus: UIButton = {
        let button = UIButton()
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    // for storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

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
            itemTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor),

            itemStatus.leadingAnchor.constraint(equalTo: itemTitle.trailingAnchor, constant: 16),
            itemStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            itemStatus.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension UITableViewCell {
    // o nome da cell como identificador, para cada cell
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
