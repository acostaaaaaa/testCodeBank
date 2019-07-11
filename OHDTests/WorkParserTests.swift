import XCTest
@testable import OHD

// MARK: - MagicTests class
class WorkParserTests: XCTestCase {
    func testWorkParserReturnsArrayOfWorkDataWithCorrectData() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "work")
        let sut = MainParser<[WorkData]>()
        // when
        let parsedData = sut.parse(data: data)
        // then
        XCTAssertNotNil(parsedData)
    }
    
    func testWorkParserReturnsNilWithIncorrectData() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "badWork")
        let sut = MainParser<[WorkData]>()
        // when
        let parsedData = sut.parse(data: data)
        // then
        XCTAssertNil(parsedData)
    }
}
