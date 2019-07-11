//
//  MagicUITests.swift
//  MagicUITests
//

import XCTest

// MARK: - MagicUITests class
class MagicUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func testHomeScreenContainsMainSections() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Reload data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        let basics = app.staticTexts["Basics"]
        let work = app.staticTexts["Work"]
        
        // Then
        XCTAssertTrue(basics.exists)
        XCTAssertTrue(work.exists)
    }
    
    func testBasicScreenContainsAllInfo() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Reload data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        let basics = app.staticTexts["Basics"]
        basics.tap()
        
        // Then
        let name = app.staticTexts["Name"]
        let age = app.staticTexts["Age"]
        let email = app.staticTexts["Email"]
        let phone = app.staticTexts["Phone"]
        let website = app.staticTexts["Website"]
        let summary = app.staticTexts["Summary"]
        
        XCTAssertTrue(name.exists)
        XCTAssertTrue(age.exists)
        XCTAssertTrue(email.exists)
        XCTAssertTrue(phone.exists)
        XCTAssertTrue(website.exists)
        XCTAssertTrue(summary.exists)
    }
    
    func testWorkScreenContainsAllInfo() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Reload data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        // When
        let work = app.staticTexts["Work"]
        work.tap()
        let reloadDataExpectation = XCTestExpectation(description: "ReloadDataExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            reloadDataExpectation.fulfill()
        }
        wait(for: [reloadDataExpectation], timeout: 4)
        // Then
        let company = app.staticTexts["Company"]
        let position = app.staticTexts["Position"]
        let date = app.staticTexts["Date"]
        let summary = app.staticTexts["Summary"]
        
        XCTAssertTrue(company.exists)
        XCTAssertTrue(position.exists)
        XCTAssertTrue(date.exists)
        XCTAssertTrue(summary.exists)
    }
}
