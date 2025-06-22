@testable import DateLine
import XCTest

class DateFormattingTests: XCTestCase {
  var testDate: Date!
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")

  override func setUp() {
    super.setUp()
    let components = DateComponents(year: 2017, month: 3, day: 1, hour: 6, minute: 43, second: 19)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    testDate = calendar.date(from: components)
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
    let result = testDate.toString(format: .custom("d MMMM yyyy"), timeZone: TimeZone(identifier: "Asia/Shanghai")!, locale: locale)
    print("Actual result: \(result)")
    XCTAssertEqual(result, "1 mars 2017")
  }
}
