//
//  Message.swift
//  Acaid
//
//  Created by Frederik Eriksen on 05/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import Foundation
import Firebase

class Message {

    var key: String
    var sender: String
    var receiver: String
    var content: String
    
    init(snapshot: DataSnapshot) {
        let dict = snapshot.value as? NSDictionary
        key = snapshot.key
        sender = dict?["senderId"] as? String ?? ""
        receiver = dict?["receiver"] as? String ?? ""
        content = dict?["text"] as? String ?? ""
    }

}
