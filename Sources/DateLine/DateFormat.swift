import Foundation

public enum DateFormat {
  case isoYear
  case isoYearMonth
  case isoDate
  case isoDateTime
  case isoDateTimeFull
  case cnDateTime
  case custom(String)

  public var formatString: String {
    switch self {
    case .isoYear:
      return "yyyy"
    case .isoYearMonth:
      return "yyyy-MM"
    case .isoDate:
      return "yyyy-MM-dd"
    case .isoDateTime:
      return "yyyy-MM-dd'T'HH:mm:ssZ"
    case .isoDateTimeFull:
      return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case .cnDateTime:
      return "yyyy-MM-dd HH:mm:ss"
    case let .custom(format):
      return format
    }
  }
}
