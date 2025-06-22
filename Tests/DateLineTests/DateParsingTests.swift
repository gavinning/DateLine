@testable import DateLine
import XCTest

class DateParsingTests: XCTestCase {
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")

  func testIsoYearFormat() {
    let date = Date("2009", format: .isoYear, timeZone: timeZone, locale: locale)
    XCTAssertNotNil(date)

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year], from: date!)
    XCTAssertEqual(components.year, 2009)
  }

  func testIsoYearMonthFormat() {
    let date = Date("2009-08", format: .isoYearMonth, timeZone: timeZone, locale: locale)
    XCTAssertNotNil(date)

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month], from: date!)
    XCTAssertEqual(components.year, 2009)
    XCTAssertEqual(components.month, 8)
  }

  func testIsoDateFormat() {
    let date = Date("2009-08-11", format: .isoDate, timeZone: timeZone, locale: locale)
    XCTAssertNotNil(date)

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month, .day], from: date!)
    XCTAssertEqual(components.year, 2009)
    XCTAssertEqual(components.month, 8)
    XCTAssertEqual(components.day, 11)
  }

  func testInvalidDateString() {
    let date = Date("invalid-date", format: .isoDate)
    XCTAssertNil(date)
  }

  func testCustomFormat() {
    let date = Date("2009-08-11 06:00:00", format: .custom("yyyy-MM-dd HH:mm:ss"), timeZone: timeZone, locale: locale)
    XCTAssertNotNil(date)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = timeZone
    formatter.locale = locale

    XCTAssertEqual(formatter.string(from: date!), "2009-08-11 06:00:00")
  }
}
