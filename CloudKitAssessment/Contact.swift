//
//  Contact.swift
//  CloudKitAssessment
//
//  Created by Christian McMullin on 2/24/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import Foundation
import CloudKit

class Contact: Equatable {
    
    var name: String
    var phoneNumber: String?
    var email: String?
    var recordID: CKRecordID?
    
    init(name: String, phoneNumber: String, email: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
}

func ==(lhs: Contact, rhs: Contact) -> Bool {
    return lhs === rhs
}
