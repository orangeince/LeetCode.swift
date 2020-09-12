import Foundation
/*
 Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

 Notice that the solution set must not contain duplicate triplets.
 
 Example 1:
    Input: nums = [-1,0,1,2,-1,-4]
    Output: [[-1,-1,2],[-1,0,1]]
 
 Example 2:
    Input: nums = []
    Output: []
 
 Example 3:
    Input: nums = [0]
    Output: []

 Constraints:
    0 <= nums.length <= 3000
    -10^5 <= nums[i] <= 10^5
 */

// 美区能过，但也需要3000+ms，国区超时过不了。。
class Solution {
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [] }
        var sortedNums = nums.sorted()
        var start = 0
        var end = sortedNums.count - 1
        guard sortedNums[end] > 0 else {
            if sortedNums[end] == 0 && sortedNums[end-1] == 0 && sortedNums[end-2] == 0 {
                return [[0,0,0]]
            } else {
                return []
            }
        }
        var result: [[Int]] = []
        var lastStart = 1
        var lastEnd = 0
        while end - start > 1 {
            let first = sortedNums[start]
            if first > 0 {
                break
            } else if first == 0 {
                if sortedNums[start+1] == 0 && sortedNums[start+2] == 0 {
                    result.append([0,0,0])
                }
                break
            } else if first == lastStart {
                start += 1
                continue
            }
            if (first + sortedNums[start + 1] + sortedNums[end]) > 0 {
                end -= 1
                continue
            } else if (first + sortedNums[end] + sortedNums[end - 1] < 0) {
                start += 1
                continue
            }
            lastStart = first
            for tail in (start+2 ... end).reversed() {
                let third = sortedNums[tail]
                if third == lastEnd { continue }
                lastEnd = third
                guard third > 0 else { break }
                let second = -(first + third)
                if second < 0 {
                    var i = start+1
                    while i < tail {
                        if sortedNums[i] == second {
                            result.append([first, second, third])
                            break
                        } else if sortedNums[i] > second {
                            break
                        }
                        i += 1
                    }
                } else {
                    var i = tail - 1
                    while i > start {
                        if sortedNums[i] == second {
                            result.append([first, second, third])
                            break
                        } else if sortedNums[i] < second {
                            break
                        }
                        i -= 1
                    }
                }
            }
            start += 1
        }
        return result
    }
}
class Solution1 {
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [] }
        var sortedNums = nums.sorted()
        var start = 0
        var end = sortedNums.count - 1
        if sortedNums[start] > 0 || sortedNums[end] < 0 {
            return []
        }
        var result: [[Int]] = []
        while end - start > 1 {
            if start > 0 && sortedNums[start] == sortedNums[start - 1] {
                start += 1
                continue
            }
            let first = sortedNums[start]
            if first > 0 {
                break
            }
            if (first + sortedNums[start + 1] + sortedNums[end]) > 0 {
                end -= 1
                continue
            } else if (first + sortedNums[end] + sortedNums[end - 1] < 0) {
                start += 1
                continue
            }
            var tail = end
            var head = start + 1
            while tail > head {
                if tail < end && sortedNums[tail] == sortedNums[tail + 1] {
                    tail -= 1
                    continue
                }
                switch first + sortedNums[head] + sortedNums[tail] {
                case 0:
                    result.append([first, sortedNums[head], sortedNums[tail]])
                    head += 1
                    break
                case 1...:
                    break
                default:
                    let second = -(first + sortedNums[tail])
                    while tail > head && sortedNums[head] < second {
                        head += 1
                    }
                    if head < tail && sortedNums[head] == second {
                        result.append([first, second, sortedNums[tail]])
                        head += 1
                        while head > start+1 && head < tail && sortedNums[head] == sortedNums[head - 1] {
                            head += 1
                        }
                    }
                }
                tail -= 1
            }
            start += 1
        }
        return result
    }
}
class Solution2 {
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [] }
        var sortedNums = nums.sorted()
        var result: [[Int]] = []
        var end = sortedNums.count - 1
        
        for first in 0 ..< sortedNums.count - 2 {
            if sortedNums[first] > 0 {
                break
            }
            if first > 0 && sortedNums[first] == sortedNums[first - 1] {
                continue
            }
            while end > first + 1 && sortedNums[first] + sortedNums[first + 1] + sortedNums[end] > 0 {
                end -= 1
            }
            guard end - first > 1 else {
                break
            }
            var third = end
            let target = -sortedNums[first]
            for second in first + 1 ..< end {
                if second > first + 1 && sortedNums[second] == sortedNums[second - 1] {
                    continue
                }
                while second < third && sortedNums[second] + sortedNums[third] > target {
                    third -= 1
                }
                if second >= third {
                    break
                }
                if sortedNums[second] + sortedNums[third] == target {
                    result.append([sortedNums[first], sortedNums[second], sortedNums[third]])
                    third -= 1
                }
            }
        }

        return result
    }
}
//Solution.threeSum([-1,0,1,2,-1,-4])
//Solution.threeSum([-2,0,0,2,2])
//Solution1.threeSum([-1,0,1,2,-1,-4])
//Solution1.threeSum([-2,0,0,2,2])
//Solution1.threeSum([3,0,-2,-1,1,2])
Solution1.threeSum([-3,-3,1,2,-3,0,0,4,-1,3,-4,-2])
