import XCTest
@testable import DateLine

class DateComparisonTests: XCTestCase {
    var baseDate: Date!
    let timeZone = TimeZone(identifier: "UTC")!
    let locale = Locale(identifier: "en_US_POSIX")
    
    override func setUp() {
        super.setUp()
        let components = DateComponents(year: 2022, month: 1, day: 7, hour: 19, minute: 25, second: 53)
        self.baseDate = Calendar(identifier: .gregorian).date(from: components)
    }
    
    func testIsToday() {
        let today = Date()
        XCTAssertTrue(today.compare(.isToday))
    }
    
    func testIsTomorrow() {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        XCTAssertTrue(tomorrow.compare(.isTomorrow))
    }
    
    func testIsSameDay() {
        let sameDay = Calendar.current.date(byAdding: .hour, value: 2, to: baseDate)!
        XCTAssertTrue(baseDate.compare(.isSameDay(as: sameDay)))
    }
    
    func testIsSameMonth() {
        let sameMonth = Calendar.current.date(byAdding: .day, value: 10, to: baseDate)!
        XCTAssertTrue(baseDate.compare(.isSameMonth(as: sameMonth)))
    }
    
    func testIsWeekend() {
        // 2022-01-08 is Saturday
        let saturday = Calendar.current.date(from: DateComponents(year: 2022, month: 1, day: 8))!
        XCTAssertTrue(saturday.compare(.isWeekend))
    }
}