@testable import DateLine
import Testing
import Foundation

@Suite("DateParsing Tests")
struct DateParsingTests {
  let timeZone = TimeZone(identifier: "UTC")!
  let locale = Locale(identifier: "en_US_POSIX")

  @Test
  func isoYearFormat() {
    let date = Date("2009", format: .isoYear, timeZone: timeZone, locale: locale)
    #expect(date != nil)

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year], from: date!)
    #expect(components.year == 2009)
  }

  @Test
  func isoYearMonthFormat() {
    let date = Date("2009-08", format: .isoYearMonth, timeZone: timeZone, locale: locale)
    #expect(date != nil)

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month], from: date!)
    #expect(components.year == 2009)
    #expect(components.month == 8)
  }

  @Test
  func isoDateFormat() {
    let date = Date("2009-08-11", format: .isoDate, timeZone: timeZone, locale: locale)
    #expect(date != nil)

    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month, .day], from: date!)
    #expect(components.year == 2009)
    #expect(components.month == 8)
    #expect(components.day == 11)
  }

  @Test
  func invalidDateString() {
    let date = Date("invalid-date", format: .isoDate)
    #expect(date == nil)
  }

  @Test
  func customFormat() {
    let date = Date("2009-08-11 06:00:00", format: .custom("yyyy-MM-dd HH:mm:ss"), timeZone: timeZone, locale: locale)
    #expect(date != nil)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = timeZone
    formatter.locale = locale

    #expect(formatter.string(from: date!) == "2009-08-11 06:00:00")
  }
}
