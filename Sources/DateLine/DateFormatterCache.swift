import Foundation

enum DateFormatterCache {
  static let queue = DispatchQueue(label: "com.DateLine.DateFormatterCache")
  nonisolated(unsafe) static var cache: [String: DateFormatter] = [:]

  static func formatter(for format: DateFormat, timeZone: TimeZone? = .current, locale: Locale? = .current, isLenient: Bool) -> DateFormatter {
    let key = generateCacheKey(format: format, timeZone: timeZone, locale: locale, isLenient: isLenient)

    return queue.sync {
      if let cachedFormatter = cache[key] {
        return cachedFormatter
      }

      let newFormatter = DateFormatter()
      newFormatter.dateFormat = format.formatString
      newFormatter.timeZone = timeZone ?? .current
      newFormatter.locale = locale ?? Locale.current
      newFormatter.isLenient = isLenient

      cache[key] = newFormatter
      return newFormatter
    }
  }

  private static func generateCacheKey(format: DateFormat, timeZone: TimeZone?, locale: Locale?, isLenient: Bool) -> String {
    let timeZoneId = timeZone?.identifier ?? "default"
    let localeId = locale?.identifier ?? "default"
    return "\(format.formatString)|\(timeZoneId)|\(localeId)|\(isLenient)"
  }
}
