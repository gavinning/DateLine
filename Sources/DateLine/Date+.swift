import Foundation

extension Date {
  var startOfDay: Date {
    adjust(for: .startOfDay)
  }

  var localeDateTime: String {
    toString(format: .cnDateTime, timeZone: .current)
  }
}

