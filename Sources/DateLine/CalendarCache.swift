import Foundation

final class CalendarCache {
  nonisolated(unsafe) static let shared = CalendarCache()
  private let queue = DispatchQueue(label: "com.DateLine.CalendarCache")
  private var cache: [String: Calendar] = [:]
  private let maxCacheSize = 20 // 限制缓存大小

  private init() {}

  func calendar(for timeZone: TimeZone? = .current, locale: Locale? = .current) -> Calendar {
    let key = generateCacheKey(timeZone: timeZone, locale: locale)

    return queue.sync {
      if let cachedCalendar = cache[key] {
        return cachedCalendar
      }

      var newCalendar = Calendar.current
      newCalendar.timeZone = timeZone ?? .current
      newCalendar.locale = locale ?? .current

      // 缓存大小控制
      if cache.count >= maxCacheSize {
        evictLeastRecentlyUsed()
      }

      cache[key] = newCalendar
      return newCalendar
    }
  }

  private func generateCacheKey(timeZone: TimeZone?, locale: Locale?) -> String {
    let timeZoneId = timeZone?.identifier ?? TimeZone.current.identifier
    let localeId = locale?.identifier ?? Locale.current.identifier
    return "\(timeZoneId)|\(localeId)"
  }

  private func evictLeastRecentlyUsed() {
    // 简单实现：移除最早添加的项
    if let firstKey = cache.keys.first {
      cache.removeValue(forKey: firstKey)
    }
  }
}
