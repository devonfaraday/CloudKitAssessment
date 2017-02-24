//
//  ContactListTableViewController.swift
//  CloudKitAssessment
//
//  Created by Christian McMullin on 2/24/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(postsWereUpdated), name: Keys.didRefreshNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.contactCellKey, for: indexPath)
        let contact = ContactController.shared.contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func postsWereUpdated() {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationController = segue.destination as? ContactDetailViewController else { return }
        if segue.identifier == Keys.toShowContactDetailSegue {
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationController.contact = contact
        }
    }
}
