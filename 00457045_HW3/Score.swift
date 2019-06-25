import Foundation

struct Score:Codable{
    var name:String
    var date:String
    var score:String
    
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(dailys: [Score]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(dailys) {
            let url = Score.documentsDirectory.appendingPathComponent("lover").appendingPathExtension("plist")
            try? data.write(to: url)
        }
    }
    
    static func readDailysFromFile() -> [Score]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Score.documentsDirectory.appendingPathComponent("lover").appendingPathExtension("plist")
        if let data = try? Data(contentsOf: url), let dailys = try? propertyDecoder.decode([Score].self, from: data) {
            return dailys
        } else {
            return nil
        }
    }
}



