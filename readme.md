# DateLine
[参考DateHelper](https://github.com/melvitax/DateHelper.git)，核心代码由Trae实现，支持Linux

### 格式化

```swift
Date("2009", format: .isoYear)
Date("2009-08", format: .isoYearMonth)
Date("2009-08-11", format: .isoDate)
Date("2009-08-11T06:00:00-07:00", format: .isoDateTime)
Date("2009-08-11T06:00:00.000-07:00", format: .isoDateTimeFull)
Date("2009-08-11 06:00:00", format: .cnDateTime)
Date("2009-08-11 06:00:00", format: .custom("yyyy-MM-dd HH:mm:ss"))
```

## 字符串转换

```swift
Date().toString(format: .isoYear) // "2017"
Date().toString(format: .isoYearMonth) // "2017-03"
Date().toString(format: .isoDate) // "2017-03-01"
Date().toString(format: .isoDateTime) // "2017-03-01T06:43:19-05:00"
Date().toString(format: .isoDateTimeFull) // "2017-03-01T06:43:19.000-05:00"
Date().toString(format: .custom("yyyy-MM-dd HH:mm:ss")) // "2017-03-01 06:43:19"

Date().localeDateTime // "2017-03-01 06:43:19"
Date().localeDate // "2017-03-01"
Date().localeTime // "06:43:19"
```


### 时间偏移

```swift 
Date().add(10, .second)  // "18:14:41" -> "18:14:51"
Date().add(10, .minute)  // "18:14:41" -> "18:24:41"
Date().add(2, .hou)     // "18:14:41" -> "20:14:41"
Date().add(1, .day)      // "2009-12-06" -> "2009-12-07"
Date().add(2, .weekday)  //"2009-12-06" -> "2009-16-06"
Date().add(1, .weekdayOrdinal) // "2009-12-06" -> "2009-12-20"
Date().add(-2, .week)    // "2009-12-06" ->  "2009-11-22"
Date().add(2, .month)    // "2009-12-06" -> "2010-02-06"
Date().add(-2, .year)    // "2009-12-06" -> "2007-12-06"
```


### 时间调整

```swift 
Date().adjust(for: .startOfDay)
"2009-12-06 18:14:41" -> "2009-12-06 00:00:00"
Date().adjust(for: .endOfDay)
"2009-12-06 18:14:41" -> "2009-12-06 23-59-59"
Date().adjust(for: .startOfWeek)
"2009-12-08 18:14:41" -> "2009-12-06 18:14:41"
Date().adjust(for: .endOfWeek)
"2009-12-06 18:14:41" -> "2009-12-12 18:14:41"
Date().adjust(for: .startOfMonth)
"2009-12-06 18:14:41" -> "2009-12-01 18:14:41"
Date().adjust(for: .endOfMonth)
"2009-12-06 18:14:41" -> "2009-12-31 18:14:41"
Date().adjust(for: .tomorrow)
"2009-12-06 18:14:41" -> "tomorrow at 18:14:41"
Date().adjust(for: .yesterday)
"2009-12-06 18:14:41" -> "yesterday at 18:14:41"
Date().adjust(for: .nearestMinute(minute:30))
"2009-12-07 18-14-00" -> "2009-12-07 18-00-00"
"2009-12-07 18-40-00" -> "2009-12-07 18-30-00"
"2009-12-07 18-50-00" -> "2009-12-07 19-00-00"
Date().adjust(for: .nearestHour(hour:2)) 
"2009-12-07 18-00-00" -> "2009-12-08 00-00-00"
"2009-12-07 07-00-00" -> "2009-12-07 12-00-00"
"2009-12-07 03-00-00" -> "2009-12-07 00-00-00"
Date().adjust(for: .startOfYear)
"2009-12-06 18:14:41" -> "2009-01-01 00-00-00"
Date().adjust(for: .endOfYear)
"2009-12-06 18:14:41" -> "2009-12-31 23-59-59"
```


## 时间对比

```swift
Date().compare(.isToday)
Date().compare(.isTomorrow)
Date().compare(.isYesterday)
Date().compare(.isThisWeek)
Date().compare(.isNextWeek)
Date().compare(.isLastWeek)
Date().compare(.isThisYear)
Date().compare(.isNextYear)
Date().compare(.isLastYear)
Date().compare(.isInTheFuture)
Date().compare(.isInThePast)
Date().compare(.isWeekend)
"2021-12-15" != weekend
"2021-12-18" == weekend
```

```swift
firstDate.compare(.isSameDay(as: secondDate))
"2022-01-08" != "2022-01-07"
"2022-01-06" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isSameWeek(as: secondDate))
"2022-01-14" != "2022-01-07"
"2021-12-31" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isSameMonth(as: secondDate))
"2022-02-07" != "2022-01-07"
"2021-12-07" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isSameYear(as: secondDate))
"2023-01-07" != "2022-01-07"
"2021-01-07" != "2022-01-07"
"2022-01-07" == "2022-01-07"
firstDate.compare(.isEarlier(than: secondDate))
"2022-01-07 19:26:53" != "2022-01-07 19:25:53"
"2022-01-07 19:24:53" == "2022-01-07 19:25:53"
firstDate.compare(.isLater(than: secondDate))
"2022-01-07 19:28:49" == "2022-01-07 19:27:49"
"2022-01-07 19:26:49" != "2022-01-07 19:27:49"
```


## 快捷方式

```swift
Date().localeDate // "2022-01-07"
Date().localeTime // "19:26:49"
Date().localeDateTime // "2022-01-07 19:26:49"

Date().startOfDay
Date().endOfDay
Date().startOfWeek
Date().endOfWeek
Date().startOfMonth
Date().endOfMonth
Date().startOfYear
Date().endOfYear

Date().tomorrow
Date().yesterday

Date().isToday
Date().isTomorrow
Date().isYesterday
Date().isThisWeek
Date().isNextWeek
Date().isLastWeek
```


## 其他

```swift
let date = Date("2025-10-01 10:00:00", format: .cnDateTime)!

let last7Days = date.last7Days.sorted { $0 < $1 }.map{ $0.localeDate }
["2025-09-25", "2025-09-26", "2025-09-27", "2025-09-28", "2025-09-29", "2025-09-30", "2025-10-01"]

date.last7Days -> [Date]
date.last30Days -> [Date]
date.last7Date -> [String]
date.last30Date -> [String]
```
