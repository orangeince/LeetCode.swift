/*
 Determine if a 9x9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
   1. Each row must contain the digits 1-9 without repetition.
   2. Each column must contain the digits 1-9 without repetition.
   3. Each of the 9 3x3 sub-boxes of the grid must contain the digits 1-9 without repetition.
 
 The Sudoku board could be partially filled, where empty cells are filled with the character '.'.
 
 Example 1:
     Input:
     [
       ["5","3",".",".","7",".",".",".","."],
       ["6",".",".","1","9","5",".",".","."],
       [".","9","8",".",".",".",".","6","."],
       ["8",".",".",".","6",".",".",".","3"],
       ["4",".",".","8",".","3",".",".","1"],
       ["7",".",".",".","2",".",".",".","6"],
       [".","6",".",".",".",".","2","8","."],
       [".",".",".","4","1","9",".",".","5"],
       [".",".",".",".","8",".",".","7","9"]
     ]
     Output: true
 
 Example 2:
     Input:
     [
       ["8","3",".",".","7",".",".",".","."],
       ["6",".",".","1","9","5",".",".","."],
       [".","9","8",".",".",".",".","6","."],
       ["8",".",".",".","6",".",".",".","3"],
       ["4",".",".","8",".","3",".",".","1"],
       ["7",".",".",".","2",".",".",".","6"],
       [".","6",".",".",".",".","2","8","."],
       [".",".",".","4","1","9",".",".","5"],
       [".",".",".",".","8",".",".","7","9"]
     ]
     Output: false
     Explanation: Same as Example 1, except with the 5 in the top left corner being
         modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
 
 Note:
     A Sudoku board (partially filled) could be valid but is not necessarily solvable.
     Only the filled cells need to be validated according to the mentioned rules.
     The given board contain only digits 1-9 and the character '.'.
     The given board size is always 9x9.
 */
class Solution {
    static func isValidSodoku(_ board: [[Character]]) -> Bool {
        var rowSet = Set<Character>()
        var columnSet = Set<Character>()
        var blockSet = Set<Character>()
        for n in 0..<9 {
            rowSet.removeAll(keepingCapacity: true)
            columnSet.removeAll(keepingCapacity: true)
            blockSet.removeAll(keepingCapacity: true)
            for m in 0..<9 {
                let row = board[n][m]
                if row != "." {
                    guard !rowSet.contains(row) else { return false }
                    rowSet.insert(row)
                }
                let column = board[m][n]
                if column != "." {
                    guard !columnSet.contains(column) else { return false }
                    columnSet.insert(column)
                }
                let block = board[(n / 3) * 3 + m / 3][(n % 3) * 3 + m % 3]
                if block != "." {
                    guard !blockSet.contains(block) else {
                        print(block)
                        return false }
                    blockSet.insert(block)
                }
            }
        }
        return true
    }
}
class Solution2 {
    static func isValidSodoku(_ board: [[Character]]) -> Bool {
        var rows: [[Character: Bool]] = .init(repeating: [:], count: 9)
        var columns: [[Character: Bool]] = .init(repeating: [:], count: 9)
        var blocks: [[Character: Bool]] = .init(repeating: [:], count: 9)
        for i in 0..<9 {
            for j in 0..<9 {
                guard board[i][j] != "." else { continue }
                let char = board[i][j]
                let k = (i / 3) * 3 + j / 3
                guard rows[i][char] != true,
                      columns[j][char] != true,
                      blocks[k][char] != true
                    else { return false }
                rows[i][char] = true
                columns[j][char] = true
                blocks[k][char] = true
            }
        }
        return true
    }
}
Solution2.isValidSodoku([
    ["8","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
  ])
Solution2.isValidSodoku([
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
  ])
