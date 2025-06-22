import Foundation

public extension Date {
  var localeDateTime: String {
    toString(format: .cnDateTime, timeZone: .current)
  }

  var localeDate: String {
    toString(format: .custom("yyyy-MM-dd"), timeZone: .current)
  }

  var localeTime: String {
    toString(format: .custom("HH:mm:ss"), timeZone: .current)
  }
}

public extension Date {
  var last7Days: [Date] {
    lastDays(7)
  }

  var last30Days: [Date] {
    lastDays(30)
  }

  var last7Date: [String] {
    last7Days.map { $0.localeDate }
  }

  var last30Date: [String] {
    last30Days.map { $0.localeDate }
  }

  func lastDays(_ count: Int) -> [Date] {
    (1...count).map { self.addingTimeInterval(TimeInterval(-$0 * 24 * 60 * 60)) }
  }
}

public extension Date {
  var startOfDay: Date {
    adjust(for: .startOfDay)
  }

  var endOfDay: Date {
    adjust(for: .endOfDay)
  }

  var startOfWeek: Date {
    adjust(for: .startOfWeek)
  }

  var endOfWeek: Date {
    adjust(for: .endOfWeek)
  }

  var startOfMonth: Date {
    adjust(for: .startOfMonth)
  }

  var endOfMonth: Date {
    adjust(for: .endOfMonth)
  }

  var startOfYear: Date {
    adjust(for: .startOfYear)
  }

  var endOfYear: Date {
    adjust(for: .endOfYear)
  }

  var tomorrow: Date {
    adjust(for: .tomorrow)
  }

  var yesterday: Date {
    adjust(for: .yesterday)
  }

  var isToday: Bool {
    compare(.isToday)
  }

  var isTomorrow: Bool {
    compare(.isTomorrow)
  }

  var isYesterday: Bool {
    compare(.isYesterday)
  }

  var isThisWeek: Bool {
    compare(.isThisWeek)
  }

  var isNextWeek: Bool {
    compare(.isNextWeek)
  }

  var isLastWeek: Bool {
    compare(.isLastWeek)
  }
}
