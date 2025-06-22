import Foundation

enum CalendarCache {
    static let queue = DispatchQueue(label: "com.DateLine.CalendarCache")
    nonisolated(unsafe) static var cache: [String: Calendar] = [:]
    
    static func calendar(for timeZone: TimeZone? = nil, locale: Locale? = nil) -> Calendar {
        let key = generateCacheKey(timeZone: timeZone, locale: locale)
        
        return queue.sync {
            if let cachedCalendar = cache[key] {
                return cachedCalendar
            }
            
            var newCalendar = Calendar.current
            newCalendar.timeZone = timeZone ?? TimeZone.current
            newCalendar.locale = locale ?? Locale.current
            
            cache[key] = newCalendar
            return newCalendar
        }
    }
    
    private static func generateCacheKey(timeZone: TimeZone?, locale: Locale?) -> String {
        let timeZoneId = timeZone?.identifier ?? "default"
        let localeId = locale?.identifier ?? "default"
        return "\(timeZoneId)|\(localeId)"
    }
}