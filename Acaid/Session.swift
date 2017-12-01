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
    
    //var key: String
    var title: String
    var desc: String
    var type: String
    var creator: String

    init(snapshot: DataSnapshot) {
    
       /* guard let dict = snapshot.value as? [String: Any],
        let title = dict["title"] as? String,
        let desc = dict["description"] as? String,
        let type = dict["type"] as? String,
        let creator = dict["initiator"] as? String
            else {
                return nil */
        let dict = snapshot.value as? NSDictionary
        
        title = dict?["title"] as? String ?? ""
        desc = dict?["description"] as? String ?? ""
        type = dict?["type"] as? String ?? ""
        creator = dict?["initiator"] as? String ?? ""
        
        }
        
     /*   self.key = snapshot.key
        self.title = title
        self.desc = desc
        self.type = type
        self.creator = creator */
        
    }


