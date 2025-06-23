import Foundation

final class DateFormatterCache {
  nonisolated(unsafe) static let shared = DateFormatterCache()
  private let queue = DispatchQueue(label: "com.DateLine.DateFormatterCache")
  private var cache: [String: DateFormatter] = [:]
  private let maxCacheSize = 50 // 限制缓存大小

  private init() {}

  func formatter(for format: DateFormat, timeZone: TimeZone? = TimeZone(identifier: "UTC"), locale: Locale? = Locale(identifier: "en_US_POSIX"), isLenient: Bool = false) -> DateFormatter {
    let key = generateCacheKey(format: format, timeZone: timeZone, locale: locale, isLenient: isLenient)

    return queue.sync {
      if let cachedFormatter = cache[key] {
        return cachedFormatter
      }

      let newFormatter = DateFormatter()
      newFormatter.dateFormat = format.formatString
      newFormatter.timeZone = timeZone
      newFormatter.locale = locale
      newFormatter.isLenient = isLenient

      // 验证dateFormat的有效性
      assert(!newFormatter.dateFormat.isEmpty, "无效的日期格式字符串: \(format.formatString)")

      // 缓存大小控制
      if cache.count >= maxCacheSize {
        evictLeastRecentlyUsed()
      }

      cache[key] = newFormatter
      return newFormatter
    }
  }

  private func generateCacheKey(format: DateFormat, timeZone: TimeZone?, locale: Locale?, isLenient: Bool) -> String {
    let timeZoneId = timeZone?.identifier ?? "UTC"
    let localeId = locale?.identifier ?? "en_US_POSIX"
    return "\(format.formatString)|\(timeZoneId)|\(localeId)|\(isLenient)"
  }

  private func evictLeastRecentlyUsed() {
    // 简单实现：移除最早添加的项（实际应用中可使用LRU算法）
    if let firstKey = cache.keys.first {
      cache.removeValue(forKey: firstKey)
    }
  }
}
