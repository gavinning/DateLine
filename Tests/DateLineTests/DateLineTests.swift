@testable import DateLine
import XCTest

class DateLineTests: XCTestCase {
  let date = Date("2025-01-01 10:00:00", format: .cnDateTime)

  func testFormat() {
    let date = Date("2009", format: .isoYear, timeZone: .utc)
    XCTAssertEqual(date!.toString(format: .isoYear), "2009")
  }

  func testLocaleDateTime() {
    XCTAssertEqual(date?.localeDateTime, "2025-01-01 10:00:00")
    XCTAssertEqual(date?.startOfDay.localeDateTime, "2025-01-01 00:00:00")
  }

  func testLocaleDateTimeOffset() {
    XCTAssertEqual(date?.add(1, .year).localeDateTime, "2026-01-01 10:00:00")
    XCTAssertEqual(date?.add(-1, .year).localeDateTime, "2024-01-01 10:00:00")

    XCTAssertEqual(date?.add(1, .month).localeDateTime, "2025-02-01 10:00:00")
    XCTAssertEqual(date?.add(-1, .month).localeDateTime, "2024-12-01 10:00:00")

    XCTAssertEqual(date?.add(1, .day).localeDateTime, "2025-01-02 10:00:00")
    XCTAssertEqual(date?.add(-1, .day).localeDateTime, "2024-12-31 10:00:00")

    XCTAssertEqual(date?.add(1, .week).localeDateTime, "2025-01-08 10:00:00")
    XCTAssertEqual(date?.add(-1, .week).localeDateTime, "2024-12-25 10:00:00")

    XCTAssertEqual(date?.add(1, .day).localeDateTime, "2025-01-02 10:00:00")
    XCTAssertEqual(date?.add(-1, .day).localeDateTime, "2024-12-31 10:00:00")

    XCTAssertEqual(date?.add(1, .hour).localeDateTime, "2025-01-01 11:00:00")
    XCTAssertEqual(date?.add(-1, .hour).localeDateTime, "2025-01-01 09:00:00")

    XCTAssertEqual(date?.add(1, .minute).localeDateTime, "2025-01-01 10:01:00")
    XCTAssertEqual(date?.add(-1, .minute).localeDateTime, "2025-01-01 09:59:00")

    XCTAssertEqual(date?.add(1, .second).localeDateTime, "2025-01-01 10:00:01")
    XCTAssertEqual(date?.add(-1, .second).localeDateTime, "2025-01-01 09:59:59")
  }
}
