//
//  daily.swift
//  期末-天氣app
//
//  Created by User02 on 2019/6/22.
//  Copyright © 2019 00657123. All rights reserved.
//

import Foundation

struct Daily:Codable{
    var dailytext:String
    var date:String
    var theme:String
    
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(dailys: [Daily]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(dailys) {
            let url = Daily.documentsDirectory.appendingPathComponent("lover").appendingPathExtension("plist")
            try? data.write(to: url)
        }
    }
    
    static func readDailysFromFile() -> [Daily]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Daily.documentsDirectory.appendingPathComponent("lover").appendingPathExtension("plist")
        if let data = try? Data(contentsOf: url), let dailys = try? propertyDecoder.decode([Daily].self, from: data) {
            return dailys
        } else {
            return nil
        }
    }
}



