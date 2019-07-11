import XCTest
@testable import OHD

// MARK: - MagicTests class
class BasicPresenterTests: XCTestCase {
    
    func testBasicPresenterReturnsBasicInfoCorrectly() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "basic")
        let sut = BasicPresenter(service: MockNetworkingService<BasicInfo>(endpoint: "basic",
                                                                              data: data))
        let dummyBasicInfo = DummyFactory.createDummyBasicInfo()
        // when
        sut.start()
        // then
        XCTAssertEqual(sut.age, "\(dummyBasicInfo.age) Years")
        XCTAssertEqual(sut.email, dummyBasicInfo.email)
        XCTAssertEqual(sut.name, dummyBasicInfo.name)
        XCTAssertEqual(sut.phone, dummyBasicInfo.phone)
        XCTAssertEqual(sut.website, dummyBasicInfo.website)
        XCTAssertEqual(sut.summary, dummyBasicInfo.summary)
    }
    
    func testBasicPresenterStartCallsFetchDataService() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "basic")
        let mockedService = MockNetworkingService<[DataSection]>(endpoint: "basic.json",
                                                                 data: data,
                                                                 session: MockURLSession())
        let sut = MainPresenter(service: mockedService)
        // when
        sut.start()
        // then
        XCTAssertTrue(mockedService.fetchDataCalled)
    }
}
