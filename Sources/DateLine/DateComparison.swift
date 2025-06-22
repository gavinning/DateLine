import Foundation

public enum DateComparison {
    case isToday
    case isTomorrow
    case isYesterday
    case isThisWeek
    case isNextWeek
    case isLastWeek
    case isThisYear
    case isNextYear
    case isLastYear
    case isInTheFuture
    case isInThePast
    case isWeekend
    case isSameDay(as: Date)
    case isSameWeek(as: Date)
    case isSameMonth(as: Date)
    case isSameYear(as: Date)
    case isEarlier(than: Date)
    case isLater(than: Date)
}

public extension Date {
    /// 比较日期
    /// - Parameters:
    ///   - comparison: 比较类型
    ///   - timeZone: 时区（可选，默认为当前时区）
    ///   - locale: 地区（可选，默认为当前地区）
    /// - Returns: 比较结果（布尔值）
    func compare(_ comparison: DateComparison, timeZone: TimeZone? = nil, locale: Locale? = nil) -> Bool {
        let calendar = CalendarCache.calendar(for: timeZone, locale: locale)
        let now = Date()
        
        switch comparison {
        case .isToday:
            return calendar.isDateInToday(self)
        
        case .isTomorrow:
            return calendar.isDateInTomorrow(self)
        
        case .isYesterday:
            return calendar.isDateInYesterday(self)
        
        case .isThisWeek:
            return calendar.isDate(self, equalTo: now, toGranularity: .weekOfYear)
        
        case .isNextWeek:
            guard let nextWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: now) else { return false }
            return calendar.isDate(self, equalTo: nextWeek, toGranularity: .weekOfYear)
        
        case .isLastWeek:
            guard let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: now) else { return false }
            return calendar.isDate(self, equalTo: lastWeek, toGranularity: .weekOfYear)
        
        case .isThisYear:
            return calendar.isDate(self, equalTo: now, toGranularity: .year)
        
        case .isNextYear:
            guard let nextYear = calendar.date(byAdding: .year, value: 1, to: now) else { return false }
            return calendar.isDate(self, equalTo: nextYear, toGranularity: .year)
        
        case .isLastYear:
            guard let lastYear = calendar.date(byAdding: .year, value: -1, to: now) else { return false }
            return calendar.isDate(self, equalTo: lastYear, toGranularity: .year)
        
        case .isInTheFuture:
            return self > now
        
        case .isInThePast:
            return self < now
        
        case .isWeekend:
            let weekday = calendar.component(.weekday, from: self)
            return weekday == 1 || weekday == 7
        
        case .isSameDay(as: let otherDate):
            return calendar.isDate(self, inSameDayAs: otherDate)
        
        case .isSameWeek(as: let otherDate):
            return calendar.isDate(self, equalTo: otherDate, toGranularity: .weekOfYear)
        
        case .isSameMonth(as: let otherDate):
            return calendar.isDate(self, equalTo: otherDate, toGranularity: .month)
        
        case .isSameYear(as: let otherDate):
            return calendar.isDate(self, equalTo: otherDate, toGranularity: .year)
        
        case .isEarlier(than: let otherDate):
            return self < otherDate
        
        case .isLater(than: let otherDate):
            return self > otherDate
        }
    }
}