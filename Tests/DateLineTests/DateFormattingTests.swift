import XCTest
@testable import DateLine

class DateFormattingTests: XCTestCase {
    var testDate: Date!
    let timeZone = TimeZone(identifier: "America/New_York")!
    let locale = Locale(identifier: "en_US_POSIX")
    
    override func setUp() {
        super.setUp()
        let components = DateComponents(year: 2017, month: 3, day: 1, hour: 6, minute: 43, second: 19)
        self.testDate = Calendar(identifier: .gregorian).date(from: components)
    }
    
    func testIsoYearFormat() {
        let result = testDate.toString(format: .isoYear, timeZone: timeZone, locale: locale)
        XCTAssertEqual(result, "2017")
    }
    
    func testIsoYearMonthFormat() {
        let result = testDate.toString(format: .isoYearMonth, timeZone: timeZone, locale: locale)
        XCTAssertEqual(result, "2017-03")
    }
    
    func testIsoDateFormat() {
        let result = testDate.toString(format: .isoDate, timeZone: timeZone, locale: locale)
        XCTAssertEqual(result, "2017-03-01")
    }
    
    func testCustomFormat() {
        let result = testDate.toString(format: .custom("yyyy-MM-dd HH:mm:ss"), timeZone: timeZone, locale: locale)
        XCTAssertEqual(result, "2017-03-01 06:43:19")
    }
    
    func testLocaleSpecificFormat() {
        let locale = Locale(identifier: "fr_FR")
        let result = testDate.toString(format: .custom("MMM d, yyyy"), locale: locale)
        XCTAssertEqual(result, "mars 1, 2017")
    }
}