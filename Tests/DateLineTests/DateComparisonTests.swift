@testable import DateLine
import Testing
import Foundation

@Suite("DateComparison Tests")
struct DateComparisonTests {
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")
  
  private var testComponents: DateComponents {
    var components = DateComponents(year: 2022, month: 1, day: 7, hour: 0, minute: 0, second: 0)
    components.timeZone = timeZone
    return components
  }
  
  private var baseDate: Date {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    return calendar.date(from: testComponents)!}
  
  private var today: Date {
    Calendar(identifier: .gregorian).date(from: testComponents)!
  }

  @Test
  func isToday() {
    let today = Date()
    #expect(today.compare(.isToday))
  }

  @Test
  func isTomorrow() {
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    #expect(tomorrow.compare(.isTomorrow))
  }

  @Test
  func isSameDay() {
    let sameDay = Calendar.current.date(byAdding: .hour, value: 2, to: baseDate)!
    #expect(baseDate.compare(.isSameDay(as: sameDay)))
  }

  @Test
  func isSameMonth() {
    let sameMonth = Calendar.current.date(byAdding: .day, value: 10, to: baseDate)!
    #expect(baseDate.compare(.isSameMonth(as: sameMonth)))
  }

  @Test
  func isWeekend() {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let saturday = calendar.date(from: DateComponents(year: 2022, month: 1, day: 8))!
    #expect(saturday.compare(.isWeekend))
  }
}
