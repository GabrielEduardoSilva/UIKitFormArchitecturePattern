//
//  FormField.swift
//  Form
//
//  Created by Gabriel Eduardo on 07/11/24.
//

import UIKit

protocol FormFieldDelegate: AnyObject {
    func fieldDidChangeValue(_ field: FormField) -> Bool
}

protocol FormField: AnyObject {
    var key: String { get }
    var height: CGFloat { get }
    var delegate: FormFieldDelegate? { get set }

    func register(for tableView: UITableView) // Registra a célula na tableView
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell // Devolve uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) // Quando seleciona uma célula
}
