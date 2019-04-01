/**Longest Palindromic Substring
 
 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.
 
 Example 1:
 
     Input: "babad"
     Output: "bab"
     Note: "aba" is also a valid answer.
 
 Example 2:
 
     Input: "cbbd"
     Output: "bb"
 */
protocol SolutionType {
     static func longestPalindrome(_ s: String) -> String
}

/// Too slow..
///
/// Result of LeetCode's testcases:
///  - Runtime: 5488 ms
///  - Memory: 19.7 MB
///  - Swift version: 4.2
class Solution1: SolutionType {
    static func longestPalindrome(_ s: String) -> String {
        guard !s.isEmpty else { return "" }
        func isPalindrome(from: String.Index, to: String.Index) -> Bool {
            var i = from
            var j = to
            while i < j {
                guard s[i] == s[j] else { return false }
                i = s.index(after: i)
                j = s.index(before: j)
            }
            return true
        }
        var maxLength = 0
        var maxStr = ""
        var headIndex = s.startIndex
        while headIndex < s.endIndex {
            guard s.distance(from: headIndex, to: s.endIndex) > maxLength else { break }
            let headChar = s[headIndex]
            var tailIndex = s.index(before: s.endIndex)
            while headIndex < tailIndex {
                if s[tailIndex] == headChar {
                    let length = s.distance(from: headIndex, to: tailIndex) + 1
                    guard length > maxLength else { break }
                    if isPalindrome(from: headIndex, to: tailIndex) {
                        maxLength = length
                        maxStr = String(s[headIndex ... tailIndex])
                        break
                    }
                }
                tailIndex = s.index(before: tailIndex)
            }
            headIndex = s.index(after: headIndex)
        }
        if maxLength == 0 {
            return String(s.first!)
        }
        return maxStr
    }
}
print(Solution1.longestPalindrome("cbbd"))

