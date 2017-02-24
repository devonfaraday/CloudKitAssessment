//
//  ContactDetailViewController.swift
//  CloudKitAssessment
//
//  Created by Christian McMullin on 2/24/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var contact: Contact? {
        didSet {
            if !isViewLoaded {
                loadViewIfNeeded()
            }
            updateViews()
        }
    }
    
    // MARK: - UI Actions
    
    @IBAction func saveContactButtonTapped(_ sender: Any) {
        guard let contact = contact else {
            guard let name = nameTextField.text,
                let phoneNumber = phoneNumberTextField.text,
                let email = emailTextField.text,
                !name.isEmpty else { nameRequiredAlert(); return }
            let contact = Contact(name: name, phoneNumber: phoneNumber, email: email)
            ContactController.shared.create(contact: contact)
            let _ = navigationController?.popViewController(animated: true)
            return }
        contact.cloudKitRecord.setValue(nameTextField.text, forKeyPath: Keys.nameKey)
        contact.cloudKitRecord.setValue(phoneNumberTextField.text, forKeyPath: Keys.phoneNuberKey)
        contact.cloudKitRecord.setValue(emailTextField.text, forKeyPath: Keys.emailKey)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Function
    
    func updateViews() {
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        phoneNumberTextField.text = contact.phoneNumber
        emailTextField.text = contact.email
    }
    
    // MARK: - Alert Controller
    func nameRequiredAlert() {
        let alertController = UIAlertController(title: "Name Required", message: "Please Enter a Name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
