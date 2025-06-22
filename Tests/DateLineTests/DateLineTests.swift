@testable import DateLine
import Testing
import Foundation

@Suite("DateLine Tests", .serialized)
struct DateLineTests {
  let date = Date("2025-01-01 10:00:00", format: .cnDateTime)

  @Test
  func testFormat() {
    let date = Date("2009", format: .isoYear, timeZone: .utc)
    #expect(date!.toString(format: .isoYear) == "2009")
  }

  @Test
  func testLocaleDateTime() {
    #expect(date?.localeDateTime == "2025-01-01 10:00:00")
    #expect(date?.startOfDay.localeDateTime == "2025-01-01 00:00:00")
  }

  @Test("Test Date Offset")
  func testLocaleDateTimeOffset() {
    #expect(date?.add(1, .year).localeDateTime == "2026-01-01 10:00:00")
    #expect(date?.add(-1, .year).localeDateTime == "2024-01-01 10:00:00")

    #expect(date?.add(1, .month).localeDateTime == "2025-02-01 10:00:00")
    #expect(date?.add(-1, .month).localeDateTime == "2024-12-01 10:00:00")

    #expect(date?.add(1, .day).localeDateTime == "2025-01-02 10:00:00")
    #expect(date?.add(-1, .day).localeDateTime == "2024-12-31 10:00:00")

    #expect(date?.add(1, .week).localeDateTime == "2025-01-08 10:00:00")
    #expect(date?.add(-1, .week).localeDateTime == "2024-12-25 10:00:00")

    #expect(date?.add(1, .day).localeDateTime == "2025-01-02 10:00:00")
    #expect(date?.add(-1, .day).localeDateTime == "2024-12-31 10:00:00")

    #expect(date?.add(1, .hour).localeDateTime == "2025-01-01 11:00:00")
    #expect(date?.add(-1, .hour).localeDateTime == "2025-01-01 09:00:00")

    #expect(date?.add(1, .minute).localeDateTime == "2025-01-01 10:01:00")
    #expect(date?.add(-1, .minute).localeDateTime == "2025-01-01 09:59:00")

    #expect(date?.add(1, .second).localeDateTime == "2025-01-01 10:00:01")
    #expect(date?.add(-1, .second).localeDateTime == "2025-01-01 09:59:59")
  }

  @Test("Test Last Days")
  func testLastDays() {
    let date = Date("2025-10-01 10:00:00", format: .cnDateTime)!
    #expect(date.lastDays(1).map{ $0.localeDate } == ["2025-09-30"])
    #expect(date.lastDays(2).map{ $0.localeDate } == ["2025-09-30", "2025-09-29"])
    #expect(date.last7Date.reversed() == ["2025-09-24", "2025-09-25", "2025-09-26", "2025-09-27", "2025-09-28", "2025-09-29", "2025-09-30"])
  }
}
