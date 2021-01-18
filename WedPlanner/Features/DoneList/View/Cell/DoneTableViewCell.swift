//
//  DoneTableViewCell.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 13/01/21.
//

import UIKit

class DoneTableViewCell: UITableViewCell {
    private lazy var completedNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
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
        setupCompletedNameLabel(with: listItem.title)
    }

    // MARK: setup UI
    func setupCompletedNameLabel(with text: String) {
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        completedNameLabel.attributedText = attributedText
        completedNameLabel.text = text
    }

    func setupUi() {
        addSubview(completedNameLabel)

        completedNameLabel.autoresizesSubviews = true

        NSLayoutConstraint.activate([
            completedNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            completedNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
