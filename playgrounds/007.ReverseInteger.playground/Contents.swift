import UIKit

/** Reverse Integer
 
 Given a 32-bit signed integer, reverse digits of an integer.
 
 Example 1:
 
     Input: 123
     Output: 321
 
 Example 2:
 
     Input: -123
     Output: -321
 
 Example 3:
 
     Input: 120
     Output: 21
 
 Note: Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−2^31,  2^31 − 1]. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.
 */
protocol SolutionType {
    static func reverse(_ x: Int) -> Int
}

/// Result of LeetCode's testcases:
///  - Runtime: 8 ms
///  - Memory: 18.8 MB
///  - Swift version: 4.2
class Solution1: SolutionType {
    static func reverse(_ x: Int) -> Int {
        if x < 10 && x > -10 { return x }
        let isNg = x < 0
        var n = isNg ? -x : x
        var arr = Array<Int>.init(repeating: 0, count: 10)
        var i = 0
        var zeroChecked = false
        while n > 0 {
            let t = n % 10
            n /= 10
            if t == 0 && !zeroChecked {
                continue
            }
            zeroChecked = true
            arr[i] = t
            i += 1
        }
        var m = 0
        for j in 0..<i {
            m *= 10
            m += arr[j]
        }
        if isNg {
            return m >= 2147483648 ? 0 : -m
        } else {
            return m > 2147483648 ? 0 : m
        }
    }
}

Solution1.reverse(1534236469) // 0
Solution1.reverse(120) // 21
