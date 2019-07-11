import XCTest
@testable import OHD

// MARK: - MagicTests class
class BasicsParserTests: XCTestCase {
    func testBasicsParserReturnsBasicInfoInstanceWithCorrectData() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "basic")
        let sut = MainParser<BasicInfo>()
        // when
        let parsedData = sut.parse(data: data)
        // then
        XCTAssertNotNil(parsedData)
    }
    
    
}
