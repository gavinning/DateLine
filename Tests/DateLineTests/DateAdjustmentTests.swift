import XCTest
@testable import DateLine

class DateAdjustmentTests: XCTestCase {
    var baseDate: Date!
    let timeZone = TimeZone(identifier: "UTC")!
    let locale = Locale(identifier: "en_US_POSIX")
    
    override func setUp() {
        super.setUp()
        let components = DateComponents(year: 2009, month: 12, day: 6, hour: 18, minute: 14, second: 41)
        self.baseDate = Calendar(identifier: .gregorian).date(from: components)
    }
    
    func testStartOfDay() {
        let result = baseDate.adjust(for: .startOfDay)
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: result)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }
    
    func testEndOfDay() {
        let result = baseDate.adjust(for: .endOfDay)
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: result)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 59)
        XCTAssertEqual(components.second, 59)
    }
    
    func testStartOfMonth() {
        let result = baseDate.adjust(for: .startOfMonth)
        let components = Calendar.current.dateComponents([.day], from: result)
        XCTAssertEqual(components.day, 1)
    }
    
    func testEndOfMonth() {
        let result = baseDate.adjust(for: .endOfMonth)
        let components = Calendar.current.dateComponents([.day], from: result)
        XCTAssertEqual(components.day, 31)
    }
    
    func testNearestMinute() {
        let date = Calendar.current.date(from: DateComponents(hour: 18, minute: 40))!
        let result = date.adjust(for: .nearestMinute(minute: 30))
        let components = Calendar.current.dateComponents([.minute], from: result)
        XCTAssertEqual(components.minute, 30)
    }
}