import XCTest
@testable import OHD

// MARK: - MagicTests class
class MainParserTests: XCTestCase {
    func testMainParserReturnsArrayOfSectionsWithCorrectData() {
        // Given
        let data = DummyFactory.loadDataFromJSON(named: "sections")
        let sut = MainParser<[DataSection]>()
        // When
        let parsedData = sut.parse(data: data)
        // Then
        XCTAssertNotNil(parsedData)
    }
    
    func testMainParserReturnsNilWithIncorrectData() {
        // Given
        let data = DummyFactory.loadDataFromJSON(named: "badSections")
        let sut = MainParser<[DataSection]>()
        
        // when
        let parsedData = sut.parse(data: data)
        
        // Then
        XCTAssertNil(parsedData)
    }
}
