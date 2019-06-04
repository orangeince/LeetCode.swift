/* Container With Most Water
 
 Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
 
 Note: You may not slant the container and n is at least 2.
 
   |
 8_|
 7_|     |              |
 6_|     |              |     |
 5_|     |  |           |     |
 4_|     |  |     |     |     |
 3_|     |  |     |  |  |     |
 2_|     |  |     |  |  |  |  |
 1_|     |  |  |  |  |  |  |  |
   |__|__|__|__|__|__|__|__|__|__
 The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
 
 Example:
 
     Input: [1,8,6,2,5,4,8,3,7]
     Output: 49
 */
protocol SolutionType {
    static func maxArea(_ height: [Int]) -> Int
}


class Solution1: SolutionType {
    static func maxArea(_ height: [Int]) -> Int {
        guard height.count > 1 else {
            return 0
        }
        if height.count == 2 {
            return min(height[0], height[1])
        }
        
        func maxArea(at index: Int) -> Int {
            let value = height[index]
            var preMax = 0
            var sufMax = 0
            for i in 0 ..< index {
                if height[i] >= value {
                    preMax = value * (index - i)
                    break
                }
            }
            for j in (index ..< height.count).reversed() {
                if height[j] >= value {
                    sufMax = value * (j - index)
                    break
                }
            }
            return max(preMax, sufMax)
        }
        var result = 0
        for idx in 0..<height.count {
            result = max(result, maxArea(at: idx))
        }
        return result
    }
}

Solution1.maxArea([1,8,6,2,5,4,8,3,7])
