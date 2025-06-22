import XCTest
@testable import DateLine

class DateOffsetTests: XCTestCase {
    var baseDate: Date!
    let timeZone = TimeZone(identifier: "UTC")!
    let locale = Locale(identifier: "en_US_POSIX")
    
    override func setUp() {
        super.setUp()
        let components = DateComponents(year: 2009, month: 12, day: 6, hour: 18, minute: 14, second: 41)
        self.baseDate = Calendar(identifier: .gregorian).date(from: components)
    }
    
    func testOffsetSecond() {
        let result = baseDate.offset(.second, value: 10)
        let components = Calendar.current.dateComponents([.second], from: result)
        XCTAssertEqual(components.second, 51)
    }
    
    func testOffsetMinute() {
        let result = baseDate.offset(.minute, value: 10)
        let components = Calendar.current.dateComponents([.minute], from: result)
        XCTAssertEqual(components.minute, 24)
    }
    
    func testOffsetDay() {
        let result = baseDate.offset(.day, value: 1)
        let components = Calendar.current.dateComponents([.day], from: result)
        XCTAssertEqual(components.day, 7)
    }
    
    func testOffsetMonth() {
        let result = baseDate.offset(.month, value: 2)
        let components = Calendar.current.dateComponents([.month, .year], from: result)
        XCTAssertEqual(components.month, 2)
        XCTAssertEqual(components.year, 2010)
    }
    
    func testNegativeOffsetYear() {
        let result = baseDate.offset(.year, value: -2)
        let components = Calendar.current.dateComponents([.year], from: result)
        XCTAssertEqual(components.year, 2007)
    }
}