import XCTest
@testable import OHD

// MARK: - MagicTests class
class MainPresenterTests: XCTestCase {
    func testMainPresenterReturnsCorrectNumberOfSections() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "sections")
        let sut = MainPresenter(service: MockNetworkingService<[DataSection]>(endpoint: "sections.json",
                                                                              data: data))
        // when
        sut.start()
        // then
        XCTAssertEqual(sut.numberOfSections(), 2)
    }

    func testMainPresenterReturnsSectionsCorrectly() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "sections")
        let sut = MainPresenter(service: MockNetworkingService<[DataSection]>(endpoint: "sections.json",
                                                                              data: data))
        // when
        sut.start()
        // then
        let sections = DummyFactory.createDummySections()
        for index in 0..<sut.numberOfSections()  {
            XCTAssertEqual(sut.section(forRow: index).name, sections[index].name)
            XCTAssertEqual(sut.section(forRow: index).icon, sections[index].icon)
        }
    }
    
    func testMainPresenterStartCallsFetchDataService() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "sections")
        let mockedService = MockNetworkingService<[DataSection]>(endpoint: "sections.json",
                                                                data: data,
                                                                session: MockURLSession())
        let sut = MainPresenter(service: mockedService)
        // when
        sut.start()
        // then
        XCTAssertTrue(mockedService.fetchDataCalled)
    }
}


