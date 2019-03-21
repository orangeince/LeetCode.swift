/**
 There are two sorted arrays nums1 and nums2 of size m and n respectively.
 
 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 You may assume nums1 and nums2 cannot be both empty.
 
 Example 1:
 
     nums1 = [1, 3]
     nums2 = [2]
 
     The median is 2.0
 
 Example 2:
 
     nums1 = [1, 2]
     nums2 = [3, 4]
 
     The median is (2 + 3)/2 = 2.5
 
 */

protocol SolutionType {
    static func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double
}

/// Using the sord method of arry provide by Foundation.
///
/// Result of LeetCode's testcases:
///  - Runtime: 108 ms
///  - Memory: 19.1 MB
///  - Swift version: 4.2
class Solution1: SolutionType {
    static func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var nums = nums1 + nums2
        nums.sort()
        let count = nums.count
        let half = count / 2
        if count % 2 == 0 {
            return Double(nums[half] + nums[half - 1]) / 2.0
        } else {
            return Double(nums[half])
        }
    }
}

/// Half-fold
///
/// Result of LeetCode's testcases:
///  - Runtime: 88 ms
///  - Memory: 19.5 MB
///  - Swift version: 4.2
class Solution2: SolutionType {
    static func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let medianOf: ([Int], Int, Int) -> Double = { nums, start, end in
            let half = (start + end) / 2
            if (start + end) % 2 != 0 {
                return Double(nums[half])
            } else {
                return Double(nums[half] + nums[half - 1]) / 2.0
            }
        }
        if nums1.isEmpty || nums2.isEmpty {
            return nums1.isEmpty ? medianOf(nums2, nums2.startIndex, nums2.endIndex) : medianOf(nums1, nums1.startIndex, nums1.endIndex)
        }
        var minPos1 = nums1.startIndex
        var maxPos1 = nums1.endIndex - 1
        var minPos2 = nums2.startIndex
        var maxPos2 = nums2.endIndex - 1
        while minPos1 < maxPos1 && minPos2 < maxPos2 {
            let half1 = (maxPos1 + minPos1) / 2
            let half2 = (maxPos2 + minPos2) / 2
            if nums1[half1] <= nums2[half2] {
                if half1 == minPos1 {
                    minPos1 += 1
                    nums1[maxPos1] > nums2[maxPos2] ? (maxPos1 -= 1) : (maxPos2 -= 1)
                    break
                }
                let offset = half1 - minPos1
                minPos1 = half1
                for _ in 0..<offset {
                    if maxPos2 < minPos2 || nums1[maxPos1] >= nums2[maxPos2] {
                        maxPos1 -= 1
                    } else {
                        maxPos2 -= 1
                    }
                }
            } else {
                if half2 == minPos2 {
                    minPos2 += 1
                    nums2[maxPos2] > nums1[maxPos1] ? (maxPos2 -= 1) : (maxPos1 -= 1)
                    break
                }
                let offset = half2 - minPos2
                minPos2 = half2
                for _ in 0..<offset {
                    if maxPos1 < minPos1 || nums2[maxPos2] >= nums1[maxPos1]  {
                        maxPos2 -= 1
                    } else {
                        maxPos1 -= 1
                    }
                }
            }
        }
//        print((minPos1, maxPos1))
//        print((minPos2, maxPos2))
        if minPos1 > maxPos1 {
            return medianOf(nums2, minPos2, maxPos2 + 1)
        } else if minPos2 > maxPos2 {
            return medianOf(nums1, minPos1, maxPos1 + 1)
        } else if minPos1 == maxPos1 && minPos2 == maxPos2 {
            return Double(nums1[minPos1] + nums2[minPos2]) / 2.0
        } else {
            func result(flag: Int, nums: [Int], start: Int, end: Int) -> Double {
                let half = (start + end) / 2
                if (start + end) % 2 == 0 {
                    if flag <= nums[half - 1] {
                        return Double(nums[half - 1] + nums[half]) / 2.0
                    } else if flag >= nums[half + 1] {
                        return Double(nums[half + 1] + nums[half]) / 2.0
                    } else {
                        return Double(flag + nums[half]) / 2.0
                    }
                } else {
                    if flag <= nums[half] {
                        return Double(nums[half])
                    } else if flag >= nums[half + 1] {
                        return Double(nums[half + 1])
                    } else {
                        return Double(flag)
                    }
                }
            }
            return minPos1 == maxPos1 ? result(flag: nums1[minPos1], nums: nums2, start: minPos2, end: maxPos2)
                                      : result(flag: nums2[minPos2], nums: nums1, start: minPos1, end: maxPos1)
        }
    }
}

var nums1: [Int] = [1,3]
var nums2 = [2]
print(Solution1.findMedianSortedArrays(nums1, nums2))
print(Solution2.findMedianSortedArrays(nums1, nums2))
nums1 = [1, 2]
nums2 = [3, 4]
print(Solution1.findMedianSortedArrays(nums1, nums2))
print(Solution2.findMedianSortedArrays(nums1, nums2))
nums1 = []
nums2 = [2]
print(Solution1.findMedianSortedArrays(nums1, nums2))
print(Solution2.findMedianSortedArrays(nums1, nums2))
nums1 = [7,8]
nums2 = [1,2,3,4,5,6]
print(Solution1.findMedianSortedArrays(nums1, nums2))
print(Solution2.findMedianSortedArrays(nums1, nums2))
nums1 = [1,2]
nums2 = [-1,3]
print(Solution1.findMedianSortedArrays(nums1, nums2))
print(Solution2.findMedianSortedArrays(nums1, nums2))
nums1 = [1,2,3,4,7]
nums2 = [5,6]
print(Solution1.findMedianSortedArrays(nums1, nums2))
print(Solution2.findMedianSortedArrays(nums1, nums2))
