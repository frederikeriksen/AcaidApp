//
//  Book.swift
//  Acaid
//
//  Created by Frederik Eriksen on 04/12/2017.
//  Copyright © 2017 Acaid. All rights reserved.
//

import Foundation
import Firebase

class Book {

    var title: String
    var description: String
    var course: String
    var semester: String
    var price: String
    
    init(snapshot: DataSnapshot) {
        let dict = snapshot.value as? NSDictionary
        title = dict?["title"] as? String ?? ""
        description = dict?["description"] as? String ?? ""
        course = dict?["course"] as? String ?? ""
        semester = dict?["semester"] as? String ?? ""
        price = dict?["price"] as? String ?? ""
    }
    
}
