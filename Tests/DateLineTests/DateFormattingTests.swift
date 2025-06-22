@testable import DateLine
import Testing
import Foundation

@Suite("DateFormatting Tests")
struct DateFormattingTests {
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")
  
  private var testDate: Date {
    let components = DateComponents(year: 2017, month: 3, day: 1, hour: 6, minute: 43, second: 19)
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = timeZone
    return calendar.date(from: components)!
  }

  @Test
  func isoYearFormat() {
    let result = testDate.toString(format: .isoYear, timeZone: timeZone, locale: locale)
    #expect(result == "2017")
  }

  @Test
  func isoYearMonthFormat() {
    let result = testDate.toString(format: .isoYearMonth, timeZone: timeZone, locale: locale)
    #expect(result == "2017-03")
  }

  @Test
  func isoDateFormat() {
    let result = testDate.toString(format: .isoDate, timeZone: timeZone, locale: locale)
    #expect(result == "2017-03-01")
  }

  @Test
  func customFormat() {
    let result = testDate.toString(format: .custom("yyyy-MM-dd HH:mm:ss"), timeZone: timeZone, locale: locale)
    #expect(result == "2017-03-01 06:43:19")
  }

  @Test
  func localeSpecificFormat() {
    let locale = Locale(identifier: "fr_FR")
    let result = testDate.toString(format: .custom("d MMMM yyyy"), timeZone: TimeZone(identifier: "Asia/Shanghai")!, locale: locale)
    print("Actual result: \(result)")
    #expect(result == "1 mars 2017")
  }
}
