@testable import DateLine
import XCTest

class DateOffsetTests: XCTestCase {
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

  func testOffsetSecond() {
    let result = baseDate.add(10, .second)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.second], from: result)
    XCTAssertEqual(components.second, 51)
  }

  func testOffsetMinute() {
    let result = baseDate.add(10, .minute)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.minute], from: result)
    XCTAssertEqual(components.minute, 24)
  }

  func testOffsetDay() {
    let result = baseDate.add(1, .day)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.day], from: result)
    XCTAssertEqual(components.day, 7)
  }

  func testOffsetMonth() {
    let result = baseDate.add(2, .month)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.month, .year], from: result)
    XCTAssertEqual(components.month, 2)
    XCTAssertEqual(components.year, 2010)
  }

  func testNegativeOffsetYear() {
    let result = baseDate.add(-2, .year)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.year], from: result)
    XCTAssertEqual(components.year, 2007)
  }
}
