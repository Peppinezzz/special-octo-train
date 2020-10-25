
import Foundation

// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins

studentsGroups = studentsStr
  .components(separatedBy: "; ")
  .map { $0.split(separator: "-", maxSplits: 1)
           .map { $0.trimmingCharacters(in: .whitespaces) }}
  .reduce(into: [String: [String]]()) {
      if $0[$1[1]] != nil {
          $0[$1[1]]!.append($1[0])
      } else {
          $0[$1[1]] = [$1[0]]
      }
  }
for (k, v) in studentsGroups {
    studentsGroups[k] = v.sorted()
}


// Your code ends

print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(Int.random(in: 0...6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

for (k, v) in studentsGroups {
    studentPoints[k] = [:]
    for s in v {
        studentPoints[k]![s] = points.map { max in randomValue(maxValue: max) }
    }
}

// Your code ends

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

for (k, v) in studentPoints {
    sumPoints[k] = [:]
    for (s, ps) in v {
        sumPoints[k]![s] = ps.reduce(0) { $0 + $1 }
    }
}

// Your code ends

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

for (k, v) in studentPoints {
    groupAvg[k] =
      Float(v.map({ $1 }).reduce([]) { $0 + $1 }.reduce(0) { $0 + $1 }) /
      Float(v.map({ $1 }).reduce([]) { $0 + $1 }.count)
}

// Your code ends

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

for (k, v) in studentPoints {
    passedPerGroup[k] = []
    for (s, ps) in v {
        if ps.reduce(0) { $0 + $1 } > 59 {
            passedPerGroup[k]!.append(s)
        }
    }
}

// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
// ["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
// ["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
// ["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
// ["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
// ["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

class TimeOK {
    var hours: UInt
    var minutes: UInt
    var seconds: UInt

    init() {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
    }

    init?(hours: UInt, minutes: UInt, seconds: UInt) {
        guard 0...23 ~= hours && 0...59 ~= minutes && 0...59 ~= seconds else {
            return nil
        }
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }

    init(date: Date) {
        let calendar = Calendar.current
        self.hours = UInt(calendar.component(.hour, from: date))
        self.minutes = UInt(calendar.component(.minute, from: date))
        self.seconds = UInt(calendar.component(.second, from: date))
    }

    func toString() -> String {
        return String(format: "%02d:%02d:%02d \(hours > 12 ? "PM" : "AM")",
                      hours <= 12 ? hours : hours - 12,
                      minutes,
                      seconds)
    }

    func advance(time: TimeOK) -> TimeOK? {
        var new_seconds = seconds + time.seconds
        var new_minutes = minutes + time.minutes
        var new_hours = hours + time.hours

        if new_seconds >= 60 {
            new_seconds -= 60
            new_minutes += 1
        }
        if new_minutes >= 60 {
            new_minutes -= 60
            new_hours += 1
        }
        if new_hours >= 24 {
            new_hours -= 24
        }

        return TimeOK(hours: new_hours,
                      minutes: new_minutes,
                      seconds: new_seconds)

    }

    func withdraw(time: TimeOK) -> TimeOK? {
        let old_seconds: UInt = seconds + minutes * 60 + hours * 3600
        let withdraw_seconds: UInt = time.seconds + time.minutes * 60 + time.hours * 3600
        let new_all_seconds: UInt = old_seconds >= withdraw_seconds
          ? old_seconds - withdraw_seconds
          : withdraw_seconds - old_seconds
        let new_hours: UInt = (new_all_seconds / 3600) % 24
        let new_minutes: UInt = (new_all_seconds / 60) % 60
        let new_seconds: UInt = new_all_seconds % 60
        return TimeOK(hours: new_hours,
                      minutes: new_minutes,
                      seconds: new_seconds)
    }

    static func advance(time1: TimeOK, time2: TimeOK) -> TimeOK? {
        return time1.advance(time: time2)
    }

    static func withdraw(time1: TimeOK, time2: TimeOK) -> TimeOK? {
        return time1.withdraw(time: time2)
    }
}

let time1 = TimeOK()
let time2 = TimeOK(hours: 13,
                   minutes: 46,
                   seconds: 22)!
let time3 = TimeOK(hours: 6,
                   minutes: 47,
                   seconds: 25)!

print(time1.toString())
print(time2.toString())
print(time2.advance(time: time3)!.toString())
print(TimeOK.advance(time1: time3, time2: time2)!.toString())
print(time2.withdraw(time: time3)!.toString())
print(TimeOK.withdraw(time1: time3, time2: time2)!.toString())

// 00:00:00 AM
// 01:46:22 PM
// 08:33:47 PM
// 08:33:47 PM
// 06:58:57 AM
// 06:58:57 AM
