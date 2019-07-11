import XCTest
@testable import OHD

// MARK: - MagicTests class
class WorkPresenterTests: XCTestCase {
    
    func testMainPresenterReturnsCorrectNumberOfSections() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "work")
        let sut = WorkPresenter(service: MockNetworkingService<[WorkData]>(endpoint: "work.json",
                                                                           data: data))
        // when
        sut.start()
        // then
        XCTAssertEqual(sut.numberOfWorks(), 4)
    }
    
    func testMainPresenterReturnsSectionsCorrectly() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "work")
        let sut = WorkPresenter(service: MockNetworkingService<[WorkData]>(endpoint: "work.json",
                                                                           data: data))
        let dummyWorks = DummyFactory.createDummyWorks()
        // when
        sut.start()
        // then
        for (index, _) in dummyWorks.enumerated() {
            XCTAssertEqual(sut.work(forItemAt: index).company, dummyWorks[index].company)
            XCTAssertEqual(sut.work(forItemAt: index).endDate, dummyWorks[index].endDate)
            XCTAssertEqual(sut.work(forItemAt: index).summary, dummyWorks[index].summary)
            XCTAssertEqual(sut.work(forItemAt: index).startDate, dummyWorks[index].startDate)
            XCTAssertEqual(sut.work(forItemAt: index).position, dummyWorks[index].position)
        }
    }
    
    func testMainPresenterStartCallsFetchDataService() {
        // given
        let data = DummyFactory.loadDataFromJSON(named: "sections")
        let mockedService = MockNetworkingService<[WorkData]>(endpoint: "sections.json",
                                                              data: data,
                                                              session: MockURLSession())
        let sut = MainPresenter(service: mockedService)
        // when
        sut.start()
        // then
        XCTAssertTrue(mockedService.fetchDataCalled)
    }
}
