//
//  AddItemViewController.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import UIKit

class AddItemViewController: UIViewController {
    private lazy var viewModel = ToDoViewModel()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Title"
        textField.autocapitalizationType = .sentences
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return textField
    }()

    private lazy var cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    private lazy var saveBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSaveBarButton()
        setupNavigation()
        setupUi()
    }

    // MARK: setup UI
    func setupSaveBarButton(enabled: Bool = false, style: UIBarButtonItem.Style = .plain, color: UIColor = .systemGray) {
        saveBarButton.tintColor = color
        saveBarButton.isEnabled = enabled
        saveBarButton.style = style
    }

    func setupNavigation() {
        navigationItem.title = "New Item"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
    }

    func setupUi() {
        view.backgroundColor = .systemBackground

        view.addSubview(titleTextField)

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    // MARK: target methods, event-driven methods
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard let title = titleTextField.text, !title.isEmpty else {
            setupSaveBarButton()
            return
        }
        setupSaveBarButton(enabled: true, style: .done, color: .systemTeal)
    }

    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc func save() {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        viewModel.save(item: ListItem(title: title))
        dismiss(animated: true, completion: nil)
    }
}
