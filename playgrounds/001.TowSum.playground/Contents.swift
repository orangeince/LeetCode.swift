import UIKit

/** Two Sum
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.
 
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 
 Example:
 
     Given nums = [2, 7, 11, 15], target = 9,
 
     Because nums[0] + nums[1] = 2 + 7 = 9,
     return [0, 1].
 */
protocol SolutionType {
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int]
}

enum Solution1: SolutionType {
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0 ..< nums.count - 1 {
            for j in i + 1 ..< nums.count {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return []
    }
}

enum Solution2: SolutionType {
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var cached: [Int: Int] = [:]
        for (i, n) in nums.enumerated() {
            if let idx = cached[n] {
                return [i, idx]
            } else {
                cached [target - n] = i
            }
        }
        return []
    }
}

let nums = [2, 7, 11, 15]
let target = 9
print(Solution1.twoSum(nums, target))
print(Solution2.twoSum(nums, target))
