/**
 Given a string, find the length of the longest substring without repeating characters.
 
 Example 1:
 
     Input: "abcabcbb"
     Output: 3
     Explanation: The answer is "abc", with the length of 3.
 
 Example 2:
     Input: "bbbbb"
     Output: 1
     Explanation: The answer is "b", with the length of 1.
 
 Example 3:
     Input: "pwwkew"
     Output: 3
     Explanation: The answer is "wke", with the length of 3.
                  Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

protocol SolutionType {
    static func lengthOfLongestSubstring(_ s: String) -> Int
}

/// This solution is not passed because `Time Limit Exceeded`. The result is 986 / 987 test cases passed.
///
/// The last test case is a longest string...
class ErrorSolution: SolutionType {
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else {
            return 0
        }
        var chars = [Character]()
        var maxCount = 0
        let halfCount = s.count / 2
        var i = s.startIndex
        var pin: Character!
        var pinnedCount = 0
        while i <= s.index(before: s.endIndex) {
            pin = s[i]
            chars.append(pin)
            let next = s.index(after: i)
            var j = next
            pinnedCount += 1
            while j != s.endIndex {
                let char = s[j]
                guard !chars.contains(char) else { break }
                chars.append(char)
                j = s.index(after: j)
            }
            maxCount = max(chars.count, maxCount)
            chars.removeAll(keepingCapacity: true)
            if pinnedCount >= halfCount && maxCount > halfCount { break }
            i = next
        }
        return maxCount
    }
}

class Solution1: SolutionType {
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        guard !s.isEmpty else { return 0 }
        var maxCount = 0
        var chars = ""
        for c in s {
            if let idx = chars.index(of: c) {
                maxCount = max(chars.count, maxCount)
                chars.removeSubrange(chars.startIndex ... idx)
            }
            chars.append(c)
        }
        maxCount = max(chars.count, maxCount)
        return maxCount
    }
}

// MARK: - result check.
print(Solution1.lengthOfLongestSubstring("pwwkew"))//3
print(Solution1.lengthOfLongestSubstring("abcabcbb"))//3
print(Solution1.lengthOfLongestSubstring("bbbbb"))//1
print(Solution1.lengthOfLongestSubstring("dvdf"))//3
print(Solution1.lengthOfLongestSubstring(""))//0
print(Solution1.lengthOfLongestSubstring(" "))//1
print(Solution1.lengthOfLongestSubstring("aab"))//2

