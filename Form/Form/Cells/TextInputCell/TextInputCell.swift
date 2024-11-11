//
//  TextInputCell.swift
//  Form
//
//  Created by Gabriel Eduardo on 07/11/24.
//

import UIKit

protocol TextInputCellDelegate: AnyObject {
    func cell(_ cell: TextInputCell, didChangeValue value: String?) -> Bool
}

class TextInputCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let textField = UITextField()

    weak var delegate: TextInputCellDelegate?
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Preencha corretamente"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true // Esconde inicialmente
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        // Aqui só tem configurações de UI
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(errorLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    // Toda alteração no valor do TextField trigga essa função
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        errorLabel.isHidden = delegate?.cell(self, didChangeValue: textField.text) ?? true // Comunicação Célula -> FormField
        // O retorno define se deve aparecer uma mensagem de erro ou não. true = Sem erros / false = Com erros
    }
}

// MARK: - Configure

extension TextInputCell {
    func configure(_ viewModel: TextInputViewModel) {
        titleLabel.text = viewModel.title
        
        textField.placeholder = viewModel.title
        textField.text = viewModel.value
        textField.isSecureTextEntry = viewModel.isSecure
        textField.textAlignment = .right
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
}
