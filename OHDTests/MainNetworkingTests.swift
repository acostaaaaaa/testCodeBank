
import XCTest
@testable import OHD

// MARK: - MagicTests class
class MainNetworkingTests: XCTestCase {
    
    func testMainNetworkingFetchesSectionsCorrectly() {
        // given
        let session = MockURLSession()
        let data = DummyFactory.loadDataFromJSON(named: "sections")
        session.data = data
        let sut = MainNetworking<[DataSection]>(endpoint: "www.dummyUrl.com", session: session)
        session.response = HTTPURLResponse(url: URL(fileURLWithPath: "sections.json"), statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectation = XCTestExpectation(description: "Loading sections correctly")
        // when
        sut.fetchData() { response in
            switch response {
            case .success(let information):
                XCTAssertNotNil(information)
                XCTAssertTrue(information is [DataSection])
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMainNetworkingFailsWhenTheresNoInternet() {
        // given
        let session = MockURLSession()
        session.error = NSError(domain: "No internet", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let expectation = XCTestExpectation(description: "No internet connection")
        let sut = MainNetworking<[DataSection]>(endpoint: "www.dummyUrl.com", session: session)
        // when
        sut.fetchData() { response in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error.description, "No internet connection")
                expectation.fulfill()
            case .success:
                XCTFail()
            }
        }
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMainNetworkingFailsWithServerError() {
        // given
        let session = MockURLSession()
        session.error = NSError(domain: "Server error", code: 502, userInfo: nil)
        let expectation = XCTestExpectation(description: "Server Error")
        let sut = MainNetworking<[DataSection]>(endpoint: "www.dummyUrl.com", session: session)
        // when
        sut.fetchData() { response in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error.description, "Server Error")
                expectation.fulfill()
            case .success:
                XCTFail()
            }
        }
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMainNetworkingFailsWithAnyError() {
        // given
        let session = MockURLSession()
        session.error = NetworkError.unknown
        let expectation = XCTestExpectation(description: "Failing with any error")
        let sut = MainNetworking<[DataSection]>(endpoint: "www.dummyUrl.com", session: session)
        // when
        sut.fetchData() { response in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error.description, "Unknown Error")
                expectation.fulfill()
            case .success:
                XCTFail()
            }
        }

        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMainNetworkingFailsWhileParsingData() {
        // given
        let session = MockURLSession()
        let data = DummyFactory.loadDataFromJSON(named: "badSections")
        session.data = data
        session.response = HTTPURLResponse(url: URL(fileURLWithPath: "badSections"), statusCode: 200, httpVersion: nil, headerFields: nil)
        let sut = MainNetworking<[DataSection]>(endpoint: "www.dummyUrl.com", session: session)
        let expectation = XCTestExpectation(description: "Loading sections correctly")
        // when
        sut.fetchData() { response in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error.description, "Data was not in the correct format")
                expectation.fulfill()
            case .success:
                XCTFail()
            }
        }
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMainNetworkingFetchesBasicInfoCorrectly() {
        // given
        let session = MockURLSession()
        let data = DummyFactory.loadDataFromJSON(named: "basic")
        session.data = data
        session.response = HTTPURLResponse(url: URL(fileURLWithPath: "basic.json"), statusCode: 200, httpVersion: nil, headerFields: nil)
        let sut = MainNetworking<BasicInfo>(endpoint: "www.dummyUrl.com", session: session)
        let expectation = XCTestExpectation(description: "Loading basic info correctly")
        // when
        sut.fetchData() { response in
            switch response {
            case .success(let information):
                XCTAssertNotNil(information)
                XCTAssertTrue(information is BasicInfo)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testMainNetworkingFetchesWorkDataCorrectly() {
        // given
        let session = MockURLSession()
        let data = DummyFactory.loadDataFromJSON(named: "work")
        session.data = data
        session.response = HTTPURLResponse(url: URL(fileURLWithPath: "work.json"), statusCode: 200, httpVersion: nil, headerFields: nil)
        let sut = MainNetworking<[WorkData]>(endpoint: "www.dummyUrl.com", session: session)
        let expectation = XCTestExpectation(description: "Loading work info correctly")
        // when
        sut.fetchData() { response in
            switch response {
            case .success(let workData):
                XCTAssertNotNil(workData)
                XCTAssertTrue(workData is [WorkData])
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        // then
        wait(for: [expectation], timeout: 3)
    }
}
