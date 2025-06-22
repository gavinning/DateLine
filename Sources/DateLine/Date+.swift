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
