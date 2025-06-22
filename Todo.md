创建Swift Date的工具库

需求说明：
1、支持macOS和linux，不要使用仅macOS支持的库，比如NSCalendar，Objecive-C.runtime等
2、尽量使用纯Swift实现，不要使用C语言实现
3、遵循swift开发最佳实践，合理拆分文件，不要把所有功能都放在一个文件里
4、注释要详细，每个函数都要有注释，说明函数的作用，参数，返回值，以及可能抛出的错误
5、每个功能都要有单元测试，单元测试要覆盖所有功能，包括边界情况
6、需要功能开发完毕后，进行代码审查，确保代码质量
7、单元测试要使用XCTest框架，不要使用其他框架
8、编码过程中功能与单元测试要同步进行，不要等到功能开发完毕后再写单元测试，功能和单元测试开发完毕后，使用`swift test`命令进行测试，如果有错误，要及时修复
9、当完成所有功能，并且通过swift test命令测试后，使用`swift build`执行构建测试，确保构建成功
10、其他合理的优化可自行决定，比如性能优化，代码优化等

11、下面是对DateLine功能的调用方式也期望结果的详细说明，参考详细说明执行功能开发

### Date from a string with predefined format

```swift
 Date(fromString: "2009", format: .isoYear) // -> Date
 Date(fromString: "2009-08", format: .isoYearMonth) // -> Date
 Date(fromString: "2009-08-11", format: .isoDate) // -> Date
 Date(fromString: "2009-08-11T06:00:00-07:00", format: .isoDateTime) // -> Date
 Date(fromString: "2009-08-11T06:00:00.000-07:00", format: .isoDateTimeFull) // -> Date
 Date(fromString: "2009-08-11 06:00:00", format: .custom("yyyy-MM-dd HH:mm:ss")) // -> Date
```
Highly performant, cached and thread safe. Can optionally receive timeZone, locale or  isLenient flag.

## String From Date
Provides three ways to convert a Date object to a String


### Convert Date to String using predefined format

```swift
Date().toString(format: .isoYear)
"2017"
Date().toString(format: .isoYearMonth)
"2017-03"
Date().toString(format: .isoDate)
"2017-03-01"
Date().toString(format: .isoDateTime)
"2017-03-01T06:43:19-05:00"
Date().toString(format: .isoDateTimeFull)
"2017-03-01T06:43:19.000-05:00"
Date().toString(format: .custom("yyyy-MM-dd HH:mm:ss"))
"2017-03-01 06:43:19"
```
Highly performant, cached and thread safe. Can optionally receive timeZone and locale.


### Convert Date to String using custom format

```swift
Date().toString(format: .custom("MMM d, yyyy"))
"Mar 1, 2017"
Date().toString(format: .custom("h:mm a"))
"6:43 AM"
Date().toString(format: .custom("MMM d"))
"Wed Mar 1"
```
Highly performant, cached and thread safe. Can optionally receive timeZone and locale.


### Offset components

```swift 
Date().offset(.second, value: 10)
"18:14:41" -> "18:14:51"
Date().offset(.minute, value: 10)
"18:14:41" -> "18:24:41"
Date().offset(.hour, value: 2)
"18:14:41" -> "20:14:41"
Date().offset(.day, value: 1)
"2009-12-06" -> "2009-12-07"
Date().offset(.weekday, value: 2)
"2009-12-06" -> "2009-16-06"
Date().offset(.weekdayOrdinal, value: 1)
"2009-12-06" -> "2009-12-20"
Date().offset(.week, value: -2)
"2009-12-06" ->  "2009-11-22"
Date().offset(.month, value: 2)
"2009-12-06" -> "2010-02-06"
Date().offset(.year, value: -2)
"2009-12-06" -> "2007-12-06"
```


### Adjust date
Modifies date with predefined times like endOfDay, startOfDay startOfWeek etc.

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


## Compare Dates
Compares dates using predefined times like today, tomorrow, this year, next year etc. Returns true if it matches.

### Compare against relative date
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


### Compare against another date
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
