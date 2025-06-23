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
    let calendar = CalendarCache.shared.calendar(for: timeZone, locale: locale)
    
    switch adjustment {
    case .startOfDay:
      return calculateStartOfDay(calendar: calendar)
    case .endOfDay:
      return calculateEndOfDay(calendar: calendar)
    case .startOfWeek:
      return calculateStartOfWeek(calendar: calendar)
    case .endOfWeek:
      return calculateEndOfWeek(calendar: calendar)
    case .startOfMonth:
      return calculateStartOfMonth(calendar: calendar)
    case .endOfMonth:
      return calculateEndOfMonth(calendar: calendar)
    case .startOfYear:
      return calculateStartOfYear(calendar: calendar)
    case .endOfYear:
      return calculateEndOfYear(calendar: calendar)
    case .tomorrow:
      return calculateTomorrow(calendar: calendar)
    case .yesterday:
      return calculateYesterday(calendar: calendar)
    case .nearestMinute(let minute):
      return calculateNearestMinute(calendar: calendar, minute: minute)
    case .nearestHour(let hour):
      return calculateNearestHour(calendar: calendar, hour: hour)
    }
  }
  
  private func calculateStartOfDay(calendar: Calendar) -> Date {
    var components = calendar.dateComponents([.year, .month, .day], from: self)
    components.hour = 0
    components.minute = 0
    components.second = 0
    guard let date = calendar.date(from: components) else {
      assertionFailure("Failed to calculate startOfDay for date: \(self)")
      return self
    }
    return date
  }
  
  private func calculateEndOfDay(calendar: Calendar) -> Date {
    var components = calendar.dateComponents([.year, .month, .day], from: self)
    components.hour = 23
    components.minute = 59
    components.second = 59
    guard let date = calendar.date(from: components) else {
      assertionFailure("Failed to calculate endOfDay for date: \(self)")
      return self
    }
    return date
  }
  
  private func calculateStartOfWeek(calendar: Calendar) -> Date {
    let currentWeekday = calendar.component(.weekday, from: self)
    let daysToSubtract = (currentWeekday - calendar.firstWeekday + 7) % 7
    guard let startOfWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: calculateStartOfDay(calendar: calendar)) else {
      assertionFailure("Failed to calculate startOfWeek for date: \(self)")
      return self
    }
    return startOfWeek
  }
  
  private func calculateEndOfWeek(calendar: Calendar) -> Date {
    let currentWeekday = calendar.component(.weekday, from: self)
    let daysToAdd = (calendar.firstWeekday - currentWeekday + 6) % 7
    guard let endOfWeek = calendar.date(byAdding: .day, value: daysToAdd, to: calculateEndOfDay(calendar: calendar)) else {
      assertionFailure("Failed to calculate endOfWeek for date: \(self)")
      return self
    }
    return endOfWeek
  }
  
  private func calculateStartOfMonth(calendar: Calendar) -> Date {
    var components = calendar.dateComponents([.year, .month], from: self)
    components.day = 1
    components.hour = 0
    components.minute = 0
    components.second = 0
    guard let date = calendar.date(from: components) else {
      assertionFailure("Failed to calculate startOfMonth for date: \(self)")
      return self
    }
    return date
  }
  
  private func calculateEndOfMonth(calendar: Calendar) -> Date {
    guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) else {
      assertionFailure("Failed to get startOfMonth components for date: \(self)")
      return self
    }
    guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) else {
      assertionFailure("Failed to calculate nextMonth for date: \(self)")
      return self
    }
    guard let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth) else {
      assertionFailure("Failed to calculate endOfMonth for date: \(self)")
      return self
    }
    return calculateEndOfDay(calendar: calendar, date: endOfMonth)
  }
  
  private func calculateStartOfYear(calendar: Calendar) -> Date {
    var components = calendar.dateComponents([.year], from: self)
    components.month = 1
    components.day = 1
    components.hour = 0
    components.minute = 0
    components.second = 0
    guard let date = calendar.date(from: components) else {
      assertionFailure("Failed to calculate startOfYear for date: \(self)")
      return self
    }
    return date
  }
  
  private func calculateEndOfYear(calendar: Calendar) -> Date {
    var components = calendar.dateComponents([.year], from: self)
    components.month = 12
    components.day = 31
    components.hour = 23
    components.minute = 59
    components.second = 59
    guard let date = calendar.date(from: components) else {
      assertionFailure("Failed to calculate endOfYear for date: \(self)")
      return self
    }
    return date
  }
  
  private func calculateTomorrow(calendar: Calendar) -> Date {
    guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: self) else {
      assertionFailure("Failed to calculate tomorrow for date: \(self)")
      return self
    }
    return tomorrow
  }
  
  private func calculateYesterday(calendar: Calendar) -> Date {
    guard let yesterday = calendar.date(byAdding: .day, value: -1, to: self) else {
      assertionFailure("Failed to calculate yesterday for date: \(self)")
      return self
    }
    return yesterday
  }
  
  private func calculateNearestMinute(calendar: Calendar, minute: Int) -> Date {
    guard minute > 0 else {
      assertionFailure("Minute must be positive: \(minute)")
      return self
    }
    let currentMinute = calendar.component(.minute, from: self)
    let difference = currentMinute % minute
    let shouldRoundUp = difference > minute / 2
    let adjustmentValue = shouldRoundUp ? (minute - difference) : -difference
    guard let adjustedDate = calendar.date(byAdding: .minute, value: adjustmentValue, to: self) else {
      assertionFailure("Failed to calculate nearestMinute for date: \(self), minute: \(minute)")
      return self
    }
    return adjustedDate
  }
  
  private func calculateNearestHour(calendar: Calendar, hour: Int) -> Date {
    guard hour > 0 else {
      assertionFailure("Hour must be positive: \(hour)")
      return self
    }
    let currentHour = calendar.component(.hour, from: self)
    let difference = currentHour % hour
    let shouldRoundUp = difference > hour / 2
    let adjustmentValue = shouldRoundUp ? (hour - difference) : -difference
    guard let adjustedDate = calendar.date(byAdding: .hour, value: adjustmentValue, to: self) else {
      assertionFailure("Failed to calculate nearestHour for date: \(self), hour: \(hour)")
      return self
    }
    return adjustedDate
  }
  
  private func calculateEndOfDay(calendar: Calendar, date: Date) -> Date {
    var components = calendar.dateComponents([.year, .month, .day], from: date)
    components.hour = 23
    components.minute = 59
    components.second = 59
    guard let endOfDay = calendar.date(from: components) else {
      assertionFailure("Failed to calculate endOfDay for date: \(date)")
      return date
    }
    return endOfDay
  }
}
