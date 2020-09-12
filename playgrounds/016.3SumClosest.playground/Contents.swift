import Foundation

/*
 Given an array nums of n integers and an integer target, find three integers in nums such that the sum is closest to target. Return the sum of the three integers. You may assume that each input would have exactly one solution.
 
 Example 1:
     Input: nums = [-1,2,1,-4], target = 1
     Output: 2
     Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
  
 Constraints:
     3 <= nums.length <= 10^3
     -10^3 <= nums[i] <= 10^3
     -10^4 <= target <= 10^4
 */
class Solution {
    static func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let sorted = nums.sorted()
        var result = 10000
        var closest = 0 {
            didSet {
                if abs(closest - target) < abs(result - target) {
                    result = closest
                }
            }
        }
        for head in 0 ..< sorted.count - 2 {
            if head > 0 && sorted[head] == sorted[head - 1] {
                continue
            }
            var end = sorted.count - 1
            var mid = head + 1
            
            while mid < end {
                let sum = sorted[head] + sorted[mid] + sorted[end]
                if sum == target {
                    return target
                }
                closest = sum
                if sum > target {
                    var tail = end - 1
                    while mid < tail && sorted[tail] == sorted[end] {
                        tail -= 1
                    }
                    end = tail
                } else {
                    var m = mid + 1
                    while m < end && sorted[m] == sorted[mid] {
                        m += 1
                    }
                    mid = m
                }
            }
        }
        return result
    }
}
//Solution.threeSumClosest([1,1,1,0], 100)
Solution.threeSumClosest([1,1,-1,-1,3], 3)
