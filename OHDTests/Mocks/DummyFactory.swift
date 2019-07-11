import Foundation
@testable import OHD

class DummyFactory {
    static func createDummySections() -> [DataSection] {
        let decoder = JSONDecoder()
        if let path = Bundle(for: self).path(forResource: "sections", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
            let dummySections = try? decoder.decode([DataSection].self, from: data)
        {
            return dummySections
        }
        return [DataSection]()
    }
    
    static func createDummyBasicInfo() -> BasicInfo {
        let decoder = JSONDecoder()
        if let path = Bundle(for: self).path(forResource: "basic", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
            let basicInfo = try? decoder.decode(BasicInfo.self, from: data)
        {
            return basicInfo
        }
        return BasicInfo(name: "", email: "", phone: "", website: "", summary: "", age: 0)
    }
    
    static func createDummyWorks() -> [WorkData] {
        let decoder = JSONDecoder()
        if let path = Bundle(for: self).path(forResource: "work", ofType: "json"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
        let dummyWorks = try? decoder.decode([WorkData].self, from: data)
        {
           return dummyWorks
        }
        return [WorkData]()
    }
    
    // Helper methods
    static func loadDataFromJSON(named name: String) -> Data {
        guard let url = Bundle(for: self).url(forResource: name, withExtension: "json") else {
            fatalError("Could not find resource named: \(name)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not read data from file.")
        }
        
        return data
    }
}
