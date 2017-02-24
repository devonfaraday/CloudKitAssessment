//
//  CloudKitController.swift
//  CloudKitAssessment
//
//  Created by Christian McMullin on 2/24/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import Foundation
import CloudKit
import NotificationCenter

class ContactController {
    
    // MARK: - Properties
    
    static let shared = ContactController()
    private(set) var contacts = [Contact]() {
        didSet {
            DispatchQueue.main.async {
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: Keys.didRefreshNotification, object: self)
            }
        }
    }
    private let cloudKitManager = CloudKitManager()
    
    // MARK: - Initializer
    
    init() {
        refreshData()
    }
    
   // MARK: - Cloud Kit Functions
    
    func create(contact: Contact, completion: @escaping ((Error?) -> Void) = { _ in }) {
        let record = contact.cloudKitRecord
        cloudKitManager.save(record) { (error) in
            defer { completion(error) }
            if let error = error {
                NSLog("Error saving \(contact.name).\n\(error.localizedDescription)")
                return
            }
            self.contacts.append(contact)
        }
    }
    
    func refreshData(completion: @escaping ((Error?) -> Void) = { _ in }) {
        let sortDescriptors = [NSSortDescriptor(key: Keys.nameKey, ascending: false), NSSortDescriptor(key: Keys.phoneNuberKey, ascending: false), NSSortDescriptor(key: Keys.emailKey, ascending: false)]
        cloudKitManager.fetchRecords(ofType: Keys.contactRecordType, withSortDescriptors: sortDescriptors) { (records, error) in
            if let error = error {
                NSLog("Error in fetching record of type \(Keys.contactRecordType).\n\(error)")
            }
            guard let records = records else { return }
            self.contacts = records.flatMap { Contact(cloudKitRecord: $0) }
        }
    }
    
    func subscribeToPushNotifications(completion: @escaping ((Error?) -> Void) = { _ in }) {
        cloudKitManager.subscribeToCreationOfRecords(withType: Keys.contactRecordType) { (error) in
            if let error = error {
                NSLog("Error saving subscription.\n\(error.localizedDescription)")
            } else {
                NSLog("Subscribe to push notification for new contacts")
            }
            completion(error)
        }
    }
}
