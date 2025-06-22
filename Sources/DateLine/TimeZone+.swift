// 扩展上海时区

import Foundation

public extension TimeZone {
  // UTC时区
  static let utc = TimeZone(identifier: "UTC")!

  // 北京时区
  static let beijing = shanghai

  // 上海时区
  static let shanghai = TimeZone(identifier: "Asia/Shanghai")!
}
