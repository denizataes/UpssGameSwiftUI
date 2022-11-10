//
//  Question.swift
//  Party
//
//  Created by Deniz Ata Eş on 29.10.2022.
//

import Foundation
import SwiftUI


struct Question: Identifiable{
    var id: String = UUID().uuidString
    var question : String 
    var isRotated: Bool = false
    var extraOffset: CGFloat = 0
    var scale: CGFloat = 1
    var zIndex: Double = 0
    var image: String
    
}

var colorList: [Color] = [
    Color(red: 245/255, green: 220/255, blue: 255/255),
    Color(red: 255/255, green: 221/255, blue: 204/255),
    Color(red: 218/255, green: 245/255, blue: 181/255),
    Color(red: 255/255, green: 251/255, blue: 158/255),
    Color(red: 209/255, green: 243/255, blue: 250/255),
    Color(red: 255/255, green: 201/255, blue: 233/255),
    Color(red: 248/255, green: 255/255, blue: 170/255)
]
//Deneme



