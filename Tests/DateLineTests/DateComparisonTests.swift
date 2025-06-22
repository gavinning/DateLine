@testable import DateLine
import XCTest

class DateComparisonTests: XCTestCase {
  var baseDate: Date!
  var today: Date!
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")

  override func setUp() {
    super.setUp()
    var components = DateComponents(year: 2022, month: 1, day: 7, hour: 0, minute: 0, second: 0)
    components.timeZone = timeZone
    today = Calendar(identifier: .gregorian).date(from: components)!
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    // let saturday = calendar.date(from: DateComponents(year: 2022, month: 1, day: 8))!
    baseDate = calendar.date(from: components)
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
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let saturday = calendar.date(from: DateComponents(year: 2022, month: 1, day: 8))!
    XCTAssertTrue(saturday.compare(.isWeekend))
  }
}
