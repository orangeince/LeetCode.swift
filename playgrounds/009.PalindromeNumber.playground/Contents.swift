import UIKit

/* Palindrome Number
 
 Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
 
 Example 1:
 
     Input: 121
     Output: true
 
 Example 2:
 
     Input: -121
     Output: false
    Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 
 Example 3:
 
     Input: 10
     Output: false
     Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 
 Follow up:
 
 Coud you solve it without converting the integer to a string?
 */
protocol SolutionType {
    static func isPalindrome(_ x: Int) -> Bool
}

class Solution1: SolutionType {
    static func isPalindrome(_ x: Int) -> Bool {
        // 排除负数
        guard x >= 0 else { return false }
        // 小于10都是true
        guard x >= 10 else { return true }
        // 个位数为0则都是false
        guard x % 10 > 0 else { return false }
        // 把每位的数字放到数组里，头尾收缩比较
        var digits: [Int] = []
        var n = x
        while n > 0 {
            digits.append(n % 10)
            n /= 10
        }
        let count = digits.count
        for var j in 0 ..< count / 2 {
            guard digits[j] == digits[count - 1 - j] else { return false }
            j += 1
        }
        return true
    }
}

Solution1.isPalindrome(10)
