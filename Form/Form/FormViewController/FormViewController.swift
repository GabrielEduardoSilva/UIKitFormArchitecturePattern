//
//  ViewController.swift
//  Form
//
//  Created by Gabriel Eduardo on 07/11/24.
//

import UIKit

class FormViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // Campos do formulário
    let data = [
        TextInputFormField(
            key: FormFieldKey.fullName(),
            viewModel: .init(title: "Nome", value: "")
        ),
        
        TextInputFormField(
            key: FormFieldKey.password(),
            viewModel: .init(title: "Senha", value: "", isSecure: true)
        ),
        
        TextInputFormField(
            key: FormFieldKey.country(),
            viewModel: .init(title: "País", value: "")
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Form View"
        view.backgroundColor = .white
        
        // Adicione a tableView à view principal
        view.addSubview(tableView)
        
        // Configurações da tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        // Registrando as células dos campos na TableView
        for field in data {
            field.register(for: tableView)
        }
        
        // Atribuindo a FormViewController como delegate dos campos
        for field in data {
            field.delegate = self
        }
        
        // Constraints da tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension FormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let field = data[indexPath.row]
        return field.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let field = data[indexPath.row]
        field.tableView(tableView, didSelectRowAt: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension FormViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = data[indexPath.row]
        return field.dequeue(for: tableView, at: indexPath)
    }
}

// MARK: - FormFieldDelegate

extension FormViewController: FormFieldDelegate {
    // Comunicação FormField -> FormViewController
    
    func fieldDidChangeValue(_ field: FormField) -> Bool {
        switch field.key {
        case FormFieldKey.fullName.rawValue:
            print("Alterou o nome")
            // Colocar nome em letra maiúscula
            return true
        case FormFieldKey.password.rawValue:
            // Checar se a senha é segura
            return checkPassword(field as! TextInputFormField)
        default:
            return true
        }
    }
}

extension FormViewController {
    // Exemplo de função para validação de senha. Se a senha não for igual a "oi", exibirá um erro.
    func checkPassword(_ field: TextInputFormField) -> Bool {
        return field.viewModel.value == "oi"
    }
}



