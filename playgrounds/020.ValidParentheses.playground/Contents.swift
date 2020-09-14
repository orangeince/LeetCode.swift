/*
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:
     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.
 
 Example 1:
     Input: s = "()"
     Output: true
 
 Example 2:
     Input: s = "()[]{}"
     Output: true
 
 Example 3:
     Input: s = "(]"
     Output: false
 
 Example 4:
     Input: s = "([)]"
     Output: false
 
 Example 5:
     Input: s = "{[]}"
     Output: true

 Constraints:
     1 <= s.length <= 104
     s consists of parentheses only '()[]{}'.
 */
class Solution {
    static func isValid(_ s: String) -> Bool {
        var stack: [Character] = [s.first!]
        var idx = s.index(after: s.startIndex)
        while idx < s.endIndex {
            guard let last = stack.last else {
                stack.append(s[idx])
                idx = s.index(after: idx)
                continue
            }
            switch (last, s[idx]) {
            case ("(", ")"), ("[", "]"), ("{", "}"):
                stack.removeLast()
            default:
                stack.append(s[idx])
            }
            idx = s.index(after: idx)
        }
        return stack.isEmpty
    }
}
class Solution2 {
    static func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        var idx = s.startIndex
        var last: Character?
        while idx < s.endIndex {
            if let l = last {
                switch (l, s[idx]) {
                case ("(", ")"), ("[", "]"), ("{", "}"):
                    stack.removeLast()
                    last = stack.last
                default:
                    last = s[idx]
                    stack.append(s[idx])
                }
            } else {
                last = s[idx]
                stack.append(s[idx])
            }
            if let l = last, [")", "]", "}"].contains(l) {
                return false
            }
            idx = s.index(after: idx)
        }
        return stack.isEmpty
    }
}
class Solution3 {
    static func isValid(_ s: String) -> Bool {
        var chars = ""
        for ch in s {
            switch ch {
            case "(", "{", "[":
                chars.append(ch)
            default:
                guard let last = chars.last else {
                    chars.append(ch)
                    continue
                }
                guard (last == "(" && ch == ")")
                    || (last == "[" && ch == "]")
                    || (last == "{" && ch == "}") else {
                    return false
                }
                chars.removeLast()
            }
        }
        return chars.isEmpty
    }
}
Solution3.isValid("()")
Solution3.isValid("()[]{}")
Solution3.isValid("(]")
Solution3.isValid("([)]")
Solution3.isValid("{[]}")
