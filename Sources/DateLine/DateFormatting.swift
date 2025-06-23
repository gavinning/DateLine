import Foundation

public extension Date {
  /// 将日期转换为字符串
  /// - Parameters:
  ///   - format: 日期格式
  ///   - timeZone: 时区（可选，默认为当前时区）
  ///   - locale: 地区（可选，默认为当前地区）
  /// - Returns: 格式化后的日期字符串
  func toString(format: DateFormat, timeZone: TimeZone? = .current, locale: Locale? = .current) -> String {
    let formatter = DateFormatterCache.shared.formatter(for: format, timeZone: timeZone, locale: locale, isLenient: false)
    return formatter.string(from: self)
  }
}
