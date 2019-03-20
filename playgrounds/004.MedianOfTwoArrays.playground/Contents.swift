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

var nums1 = [1, 3]
var nums2 = [2]
print(Solution1.findMedianSortedArrays(nums1, nums2))
nums1 = [1, 2]
nums2 = [3, 4]
print(Solution1.findMedianSortedArrays(nums1, nums2))
nums1 = [1, 2, 4, 6, 10, 48]
nums2 = [12]
print(Solution1.findMedianSortedArrays(nums1, nums2))
