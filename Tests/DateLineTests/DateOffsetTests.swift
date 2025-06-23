@testable import DateLine
import Testing
import Foundation

@Suite("DateOffset Tests")
struct DateOffsetTests {
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")

  private var baseDate: Date {
    let components = DateComponents(year: 2009, month: 12, day: 6, hour: 18, minute: 14, second: 41)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    return calendar.date(from: components)!
  }

  @Test
  func offsetSecond() {
    let result = baseDate.add(10, .second)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.second], from: result)
    #expect(components.second == 51)
  }

  @Test
  func offsetMinute() {
    let result = baseDate.add(10, .minute)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.minute], from: result)
    #expect(components.minute == 24)
  }

  @Test
  func offsetDay() {
    let result = baseDate.add(1, .day)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.day], from: result)
    #expect(components.day == 7)
  }

  @Test
  func offsetMonth() {
    let result = baseDate.add(2, .month)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.month, .year], from: result)
    #expect(components.month == 2)
    #expect(components.year == 2010)
  }

  @Test
  func negativeOffsetYear() {
    let result = baseDate.add(-2, .year)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    let components = calendar.dateComponents([.year], from: result)
    #expect(components.year == 2007)
  }
}
