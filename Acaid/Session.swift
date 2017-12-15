//
//  Session.swift
//  Acaid
//
//  Created by Frederik Eriksen on 27/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import Foundation
import Firebase

class Session {
    
    // Session attributes
    var key: String
    var title: String
    var desc: String
    var type: String
    var creator: String
    var tutorRating: Double
    var pressedBy: String

    // Init Session with snapshot from Firebase
    init(snapshot: DataSnapshot) {
        let dict = snapshot.value as? NSDictionary
        
        key = snapshot.key
        title = dict?["title"] as? String ?? ""
        desc = dict?["description"] as? String ?? ""
        type = dict?["type"] as? String ?? ""
        creator = dict?["initiator"] as? String ?? ""
        tutorRating = (dict?["rating"] as? Double)!
        pressedBy = dict?["pressedBy"] as? String ?? ""
        
        }
        
    }


