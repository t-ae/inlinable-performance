import XCTest

import inlinable_performanceTests

var tests = [XCTestCaseEntry]()
tests += inlinable_performanceTests.allTests()
XCTMain(tests)
