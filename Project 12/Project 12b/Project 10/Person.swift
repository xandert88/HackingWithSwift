//
//  Person.swift
//  Project 10
//
//  Created by Alexander Thompson on 3/2/21.
//

import UIKit

class Person: NSObject, Codable {

    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
