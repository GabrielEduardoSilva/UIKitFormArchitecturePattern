//
//  FormFieldKey.swift
//  Form
//
//  Created by Gabriel Eduardo on 07/11/24.
//

enum FormFieldKey: String {

    case fullName
    case username
    case password
    case birthday
    case enabled2FA
    case twoFA
    case enabledAddress
    case country
    case province

    func callAsFunction() -> String { rawValue }
}
