//
//  Contact+CloudKit.swift
//  CloudKitAssessment
//
//  Created by Christian McMullin on 2/24/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import Foundation
import CloudKit

extension Contact {
    
     convenience init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[Keys.nameKey] as? String,
            let phoneNumber = cloudKitRecord[Keys.phoneNuberKey] as? String,
            let email = cloudKitRecord[Keys.emailKey] as? String else { return nil }
        self.init(name: name, phoneNumber: phoneNumber, email: email)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.contactRecordType)
        record.setValue(name, forKey: Keys.nameKey)
        record.setValue(phoneNumber, forKey: Keys.phoneNuberKey)
        record.setValue(email, forKey: Keys.emailKey)
        return record
    }
}
