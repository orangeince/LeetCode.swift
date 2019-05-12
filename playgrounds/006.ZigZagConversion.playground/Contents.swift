import UIKit

/** ZigZag Conversion
 
 The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)
 
     P   A   H   N
     A P L S I I G
     Y   I   R
 And then read line by line: "PAHNAPLSIIGYIR"
 
 Write the code that will take a string and make this conversion given a number of rows:
 ```
 string convert(string s, int numRows);
 ```
 
 Example 1:
 
     Input: s = "PAYPALISHIRING", numRows = 3
     Output: "PAHNAPLSIIGYIR"
 
 Example 2:
 
     Input: s = "PAYPALISHIRING", numRows = 4
     Output: "PINALSIGYAHRPI"
     Explanation:
 
     P     I    N
     A   L S  I G
     Y A   H R
     P     I
 
 */
protocol SolutionType {
    static func convert(_ s: String, _ numRows: Int) -> String
}

/// Result of LeetCode's testcases:
///  - Runtime: 60 ms, faster than 99.58%
///  - Memory: 21.2 MB, less than 5.26%
///  - Swift version: 4.2
struct Solution1: SolutionType {
    static func convert(_ s: String, _ numRows: Int) -> String {
        let count = s.count
        guard numRows > 1, count > numRows else { return s }
        var chars: [Character] = []
        for c in s {
            chars.append(c)
        }
        let original = chars
        chars.removeAll(keepingCapacity: true)
        for n in 0..<numRows {
            var isReverse = false
            let getNext: (Int) -> Int = { current in
                let offset: Int
                if n == 0 {
                    offset = numRows * 2 - 2
                } else if n == numRows-1 {
                    offset = n * 2
                } else {
                    offset = isReverse ? n * 2 : (numRows - 1 - n)  * 2
                    isReverse = !isReverse
                }
                return current + offset
            }
            var next = n
            while next < count {
                chars.append(original[next])
                next = getNext(next)
            }
        }
        return String(chars)
    }
}

print(Solution1.convert("PAYPALISHIRING", 3))
print(Solution1.convert("PAYPALISHIRING", 4))
