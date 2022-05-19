//
//  nineGagPageUITests.swift
//  nineGagPageUITests
//
//  Created by KennethT on 7/9/2016.
//  Copyright © 2016年 KennethT. All rights reserved.
//

import XCTest

class nineGagPageUITests: XCTestCase {

	override func setUp() {
		super.setUp()

		// Put setup code here. This method is called before the invocation of each test method in the class.

		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
		// UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		XCUIApplication().launch()

		// In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testExample() {
		// Use recording to get started writing UI tests.
		// Use XCTAssert and related functions to verify your tests produce the correct results.

		let app = XCUIApplication()
		let elementsQuery = app.scrollViews.otherElements
		elementsQuery.staticTexts["FRESH"].tap()
		elementsQuery.staticTexts["TRENDING"].tap()
		elementsQuery.staticTexts["HOT"].tap()

		let table = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).scrollViews.childrenMatchingType(.Table).element

		table.swipeLeft()
		table.swipeLeft()
		table.swipeRight()
		table.swipeRight()

		let lastCell = app.staticTexts["Sorry This is the end"]
		table.scrollToElement(lastCell)
	}

}

extension XCUIElement {
	func scrollToElement(element: XCUIElement) {
		while !element.visible() {
			swipeUp()
		}
	}

	func visible() -> Bool {
		guard self.exists && !CGRectIsEmpty(self.frame) else { return false }
		return CGRectContainsRect(XCUIApplication().windows.elementBoundByIndex(0).frame, self.frame)
	}

}

