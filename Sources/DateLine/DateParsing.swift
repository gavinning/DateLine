import Foundation

public extension Date {
  /// 从字符串解析日期
  /// - Parameters:
  ///   - string: 日期字符串
  ///   - format: 日期格式
  ///   - timeZone: 时区（可选，默认为当前时区）
  ///   - locale: 地区（可选，默认为当前地区）
  ///   - isLenient: 是否宽松解析（可选，默认为false）
  /// - Returns: 解析后的日期，解析失败则返回nil
  init?(_ string: String, format: DateFormat, timeZone: TimeZone? = nil, locale: Locale? = nil, isLenient: Bool = false) {
    let formatter = DateFormatterCache.formatter(for: format, timeZone: timeZone, locale: locale, isLenient: isLenient)
    guard let date = formatter.date(from: string) else {
      return nil
    }
    self = date
  }
}
