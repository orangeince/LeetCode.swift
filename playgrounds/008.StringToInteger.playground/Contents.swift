/**String to Integer
 
 Implement atoi which converts a string to an integer.
 
 The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.
 
 The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.
 
 If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.
 
 If no valid conversion could be performed, a zero value is returned.
 
 Note:
  - Only the space character ' ' is considered as whitespace character.
  - Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.
 
 Example 1:
 
     Input: "42"
     Output: 42
 
 Example 2:
 
     Input: "   -42"
     Output: -42
     Explanation: The first non-whitespace character is '-', which is the minus sign.
     Then take as many numerical digits as possible, which gets 42.
 
 Example 3:
 
     Input: "4193 with words"
     Output: 4193
     Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.
 
 Example 4:
 
     Input: "words and 987"
     Output: 0
     Explanation: The first non-whitespace character is 'w', which is not a numerical
     digit or a +/- sign. Therefore no valid conversion could be performed.
 
 Example 5:
 
     Input: "-91283472332"
     Output: -2147483648
     Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
     Thefore INT_MIN (−231) is returned.
 */
protocol SolutionType {
    static func myAtoi(_ str: String) -> Int
}

/// Use dictionary
///
/// Result of LeetCode's testcases:
///  - Runtime: 28 ms
///  - Memory: 19.6 MB
///  - Swift version: 4.2
class Solution1: SolutionType {
    static func myAtoi(_ str: String) -> Int {
        let map: [Character: Int] = ["0":0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9]
        var numbers: [Int] = Array<Int>.init(repeating: 0, count: 11)
        var n: Int = 0
        var isNegative = false
        var shouldScape = true
        var notSign = true
        var idx = 0
        for c in str where idx < numbers.count {
            if c == " " && shouldScape {
                continue
            }
            shouldScape = false
            if c == "+" && notSign {
                notSign = false
                continue
            }
            if c == "-" && notSign {
                notSign = false
                isNegative = true
                continue
            }
            notSign = false
            if c == "0" && idx == 0 {
                continue
            }
            if let i = map[c] {
                numbers[idx] = i
                idx += 1
                continue
            } else {
                break
            }
        }
        if idx == 1 {
            n = numbers[0]
        } else if idx == 11 || (idx == 10 && numbers[0] > 2) {
            return isNegative ? -2147483648 : 2147483647
        } else if idx > 0 {
            let result = numbers.prefix(idx).reduce(0) {
                $0 * 10 + $1
            }
            if result > 2147483647 {
                return isNegative ? -2147483648 : 2147483647
            }
            n = result
        }
        return isNegative ? -n : n
    }
}

//print(Solution1.myAtoi("010"))
print(Solution1.myAtoi("0-1"))
print(Solution1.myAtoi("123-"))
