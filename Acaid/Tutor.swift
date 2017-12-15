//
//  Tutor.swift
//  Acaid
//
//  Created by Frederik Eriksen on 30/11/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import Foundation
import Firebase

class Tutor: User {

    var rating: Double

    override init(snapshot: DataSnapshot) {
        // Init user
        let dict = snapshot.value as? NSDictionary
        rating = (dict?["rating"] as? Double)! / (dict?["nRaters"] as? Double)!
        super.init(snapshot: snapshot)
    }
    
}
