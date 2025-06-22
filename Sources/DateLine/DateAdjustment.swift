import Foundation

public enum DateAdjustment {
  /// 将日期调整到当天开始时间 (00:00:00)
  case startOfDay
  /// 将日期调整到当天结束时间 (23:59:59)
  case endOfDay
  /// 将日期调整到当周开始时间
  case startOfWeek
  /// 将日期调整到当周结束时间
  case endOfWeek
  /// 将日期调整到当月开始时间
  case startOfMonth
  /// 将日期调整到当月结束时间
  case endOfMonth
  /// 将日期调整到当年开始时间
  case startOfYear
  /// 将日期调整到当年结束时间
  case endOfYear
  /// 将日期调整到明天同一时间
  case tomorrow
  /// 将日期调整到昨天同一时间
  case yesterday
  /// 将日期调整到最近的指定分钟数间隔
  case nearestMinute(minute: Int)
  /// 将日期调整到最近的指定小时数间隔
  case nearestHour(hour: Int)
}

public extension Date {
  /// 调整日期到指定时间点
  /// - Parameters:
  ///   - adjustment: 调整类型
  ///   - timeZone: 时区（可选，默认为当前时区）
  ///   - locale: 地区（可选，默认为当前地区）
  /// - Returns: 调整后的日期
  func adjust(for adjustment: DateAdjustment, timeZone: TimeZone? = nil, locale: Locale? = nil) -> Date {
    let calendar = CalendarCache.calendar(for: timeZone, locale: locale)
    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

    switch adjustment {
    case .startOfDay:
      components.hour = 0
      components.minute = 0
      components.second = 0
      return calendar.date(from: components) ?? self

    case .endOfDay:
      components.hour = 23
      components.minute = 59
      components.second = 59
      return calendar.date(from: components) ?? self

    case .startOfWeek:
      let currentWeekday = calendar.component(.weekday, from: self)
      let daysToSubtract = (currentWeekday - calendar.firstWeekday + 7) % 7
      return calendar.date(byAdding: .day, value: -daysToSubtract, to: startOfDay(timeZone: timeZone, locale: locale)) ?? self

    case .endOfWeek:
      let currentWeekday = calendar.component(.weekday, from: self)
      let daysToAdd = (calendar.firstWeekday - currentWeekday + 6) % 7
      return calendar.date(byAdding: .day, value: daysToAdd, to: endOfDay(timeZone: timeZone, locale: locale)) ?? self

    case .startOfMonth:
      components.day = 1
      components.hour = 0
      components.minute = 0
      components.second = 0
      return calendar.date(from: components) ?? self

    case .endOfMonth:
      guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth(timeZone: timeZone, locale: locale)) else { return self }
      return calendar.date(byAdding: .day, value: -1, to: nextMonth)?.endOfDay(timeZone: timeZone, locale: locale) ?? self

    case .startOfYear:
      components.month = 1
      components.day = 1
      components.hour = 0
      components.minute = 0
      components.second = 0
      return calendar.date(from: components) ?? self

    case .endOfYear:
      components.month = 12
      components.day = 31
      components.hour = 23
      components.minute = 59
      components.second = 59
      return calendar.date(from: components) ?? self

    case .tomorrow:
      return calendar.date(byAdding: .day, value: 1, to: self) ?? self

    case .yesterday:
      return calendar.date(byAdding: .day, value: -1, to: self) ?? self

    case let .nearestMinute(minute):
      let currentMinute = calendar.component(.minute, from: self)
      let difference = currentMinute % minute
      let shouldRoundUp = difference > minute / 2
      let adjustmentValue = shouldRoundUp ? (minute - difference) : -difference
      return calendar.date(byAdding: .minute, value: adjustmentValue, to: self) ?? self

    case let .nearestHour(hour):
      let currentHour = calendar.component(.hour, from: self)
      let difference = currentHour % hour
      let shouldRoundUp = difference > hour / 2
      let adjustmentValue = shouldRoundUp ? (hour - difference) : -difference
      return calendar.date(byAdding: .hour, value: adjustmentValue, to: self) ?? self
    }
  }

  private func startOfDay(timeZone: TimeZone?, locale: Locale?) -> Date {
    adjust(for: .startOfDay, timeZone: timeZone, locale: locale)
  }

  private func endOfDay(timeZone: TimeZone?, locale: Locale?) -> Date {
    adjust(for: .endOfDay, timeZone: timeZone, locale: locale)
  }

  private func startOfMonth(timeZone: TimeZone?, locale: Locale?) -> Date {
    adjust(for: .startOfMonth, timeZone: timeZone, locale: locale)
  }
}
