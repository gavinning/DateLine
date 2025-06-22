import Foundation

public enum OffsetComponent {
    case second
    case minute
    case hour
    case day
    case weekday
    case weekdayOrdinal
    case week
    case month
    case year
    
    public var calendarUnit: Calendar.Component {
        switch self {
        case .second:
            return .second
        case .minute:
            return .minute
        case .hour:
            return .hour
        case .day:
            return .day
        case .weekday:
            return .weekday
        case .weekdayOrdinal:
            return .weekdayOrdinal
        case .week:
            return .weekOfYear
        case .month:
            return .month
        case .year:
            return .year
        }
    }
}

public extension Date {
    /// 偏移日期组件
    /// - Parameters:
    ///   - component: 要偏移的日期组件
    ///   - value: 偏移值（正数向前，负数向后）
    ///   - timeZone: 时区（可选，默认为当前时区）
    ///   - locale: 地区（可选，默认为当前地区）
    /// - Returns: 偏移后的日期
    func offset(_ component: OffsetComponent, value: Int, timeZone: TimeZone? = nil, locale: Locale? = nil) -> Date {
        let calendar = CalendarCache.calendar(for: timeZone, locale: locale)
        return calendar.date(byAdding: component.calendarUnit, value: value, to: self) ?? self
    }
}