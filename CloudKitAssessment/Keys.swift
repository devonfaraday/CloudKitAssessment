//
//  Keys.swift
//  CloudKitAssessment
//
//  Created by Christian McMullin on 2/24/17.
//  Copyright © 2017 Christian McMullin. All rights reserved.
//

import Foundation


struct Keys {
    
    // MARK: - CloudKit Keys
    
    static let contactRecordType = "Contact"
    static let nameKey = "name"
    static let phoneNuberKey = "phoneNumber"
    static let emailKey = "email"
    
    // MARK: - StoryBoard Segues and Reuse Identifier
    
    static let contactCellKey = "contactCell"
    static let toAddContactSegue = "toAddContact"
    static let toShowContactDetailSegue = "toShowContactDetail"
    
    // MARK: - Notification Name
    
    static let didRefreshNotification = Notification.Name("DidRefreshNotification")
    
}
