@testable import DateLine
import XCTest

class DateAdjustmentTests: XCTestCase {
  var baseDate: Date = Date("2009-12-06 18:14:41", format: .cnDateTime)!

  func testStartOfDay() {
    let result = baseDate.adjust(for: .startOfDay)
    let calendar = Calendar(identifier: .chinese)
    let components = calendar.dateComponents([.hour, .minute, .second], from: result)
    XCTAssertEqual(components.hour, 0)
    XCTAssertEqual(components.minute, 0)
    XCTAssertEqual(components.second, 0)
    XCTAssertEqual(result.localeDateTime, "2009-12-06 00:00:00")
  }

  func testEndOfDay() {
    let result = baseDate.adjust(for: .endOfDay)
    let calendar = Calendar(identifier: .chinese)
    let components = calendar.dateComponents([.hour, .minute, .second], from: result)
    XCTAssertEqual(components.hour, 23)
    XCTAssertEqual(components.minute, 59)
    XCTAssertEqual(components.second, 59)
    XCTAssertEqual(result.localeDateTime, "2009-12-06 23:59:59")
  }

  func testStartOfMonth() {
    let result = baseDate.adjust(for: .startOfMonth)
    XCTAssertEqual(result.localeDateTime, "2009-12-01 00:00:00")
  }

  func testEndOfMonth() {
    let result = baseDate.adjust(for: .endOfMonth)
    XCTAssertEqual(result.localeDateTime, "2009-12-31 23:59:59")
  }

  func testNearestMinute() {
    let calendar = Calendar(identifier: .chinese)
    let date = calendar.date(from: DateComponents(hour: 18, minute: 40))!
    let result = date.adjust(for: .nearestMinute(minute: 30))
    let components = calendar.dateComponents([.minute], from: result)
    XCTAssertEqual(components.minute, 30)
  }
}
