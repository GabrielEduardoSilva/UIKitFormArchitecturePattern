//
//  TextInputFormField.swift
//  Form
//
//  Created by Gabriel Eduardo on 07/11/24.
//

import UIKit

// MARK: - TextInputViewModel

struct TextInputViewModel {
    var title: String
    var value: String?
    var isSecure: Bool

    init(title: String, value: String? = nil, isSecure: Bool = false) {
        self.title = title
        self.value = value
        self.isSecure = isSecure
    }
}

// MARK: - FormField

final class TextInputFormField {

    let key: String
    var viewModel: TextInputViewModel

    weak var delegate: FormFieldDelegate?

    init(key: String, viewModel: TextInputViewModel) {
        self.key = key
        self.viewModel = viewModel
    }
}

extension TextInputFormField: FormField, TextInputCellDelegate {
    var height: CGFloat { 44.0 }
    
    // MARK: - FormField
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func register(for tableView: UITableView) {
        tableView.register(TextInputCell.self, forCellReuseIdentifier: "TextInputCell")
    }

    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
        cell.delegate = self // Atribuindo delegate para comunicação Célula -> FormField
        cell.configure(viewModel) // Passando configurações da célula
        return cell
    }
    
    // MARK: - TextInputCellDelegate
    
    func cell(_ cell: TextInputCell, didChangeValue value: String?) -> Bool {
        viewModel.value = value // Alterando o valor
        return delegate?.fieldDidChangeValue(self) ?? true // Comunicação FormField -> FormViewController
    }
}
