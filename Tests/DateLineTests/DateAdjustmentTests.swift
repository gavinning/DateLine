@testable import DateLine
import Testing
import Foundation

@Suite("DateAdjustment Tests")
struct DateAdjustmentTests {
  let baseDate: Date = Date("2009-12-06 18:14:41", format: .cnDateTime)!

  @Test
  func startOfDay() {
    let result = baseDate.adjust(for: .startOfDay)
    let calendar = Calendar(identifier: .chinese)
    let components = calendar.dateComponents([.hour, .minute, .second], from: result)
    #expect(components.hour == 0)
    #expect(components.minute == 0)
    #expect(components.second == 0)
    #expect(result.localeDateTime == "2009-12-06 00:00:00")
  }

  @Test
  func endOfDay() {
    let result = baseDate.adjust(for: .endOfDay)
    let calendar = Calendar(identifier: .chinese)
    let components = calendar.dateComponents([.hour, .minute, .second], from: result)
    #expect(components.hour == 23)
    #expect(components.minute == 59)
    #expect(components.second == 59)
    #expect(result.localeDateTime == "2009-12-06 23:59:59")
  }

  @Test
  func startOfMonth() {
    let result = baseDate.adjust(for: .startOfMonth)
    #expect(result.localeDateTime == "2009-12-01 00:00:00")
  }

  @Test
  func endOfMonth() {
    let result = baseDate.adjust(for: .endOfMonth)
    #expect(result.localeDateTime == "2009-12-31 23:59:59")
  }

  @Test
  func nearestMinute() {
    let calendar = Calendar(identifier: .chinese)
    let date = calendar.date(from: DateComponents(hour: 18, minute: 40))!
    let result = date.adjust(for: .nearestMinute(minute: 30))
    let components = calendar.dateComponents([.minute], from: result)
    #expect(components.minute == 30)
  }
}
