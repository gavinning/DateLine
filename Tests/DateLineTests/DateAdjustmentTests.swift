@testable import DateLine
import XCTest

class DateAdjustmentTests: XCTestCase {
  var baseDate: Date!
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")

  override func setUp() {
    super.setUp()
    let components = DateComponents(year: 2009, month: 12, day: 6, hour: 18, minute: 14, second: 41)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    baseDate = calendar.date(from: components)
  }

  func testStartOfDay() {
    let result = baseDate.adjust(for: .startOfDay)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.hour, .minute, .second], from: result)
    XCTAssertEqual(components.hour, 0)
    XCTAssertEqual(components.minute, 0)
    XCTAssertEqual(components.second, 0)
  }

  func testEndOfDay() {
    let result = baseDate.adjust(for: .endOfDay)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.hour, .minute, .second], from: result)
    XCTAssertEqual(components.hour, 23)
    XCTAssertEqual(components.minute, 59)
    XCTAssertEqual(components.second, 59)
  }

  func testStartOfMonth() {
    let result = baseDate.adjust(for: .startOfMonth)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.day], from: result)
    XCTAssertEqual(components.day, 1)
  }

  func testEndOfMonth() {
    let result = baseDate.adjust(for: .endOfMonth)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.day], from: result)
    XCTAssertEqual(components.day, 31)
  }

  func testNearestMinute() {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let date = calendar.date(from: DateComponents(hour: 18, minute: 40))!
    let result = date.adjust(for: .nearestMinute(minute: 30))
    let components = calendar.dateComponents([.minute], from: result)
    XCTAssertEqual(components.minute, 30)
  }
}
