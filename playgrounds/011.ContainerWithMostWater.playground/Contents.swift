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


// 暴力枚举法，运行超时。。 第49/50 测试用例没通过
class Solution1: SolutionType {
    static func maxArea(_ height: [Int]) -> Int {
        guard height.count > 1 else {
            return 0
        }
        if height.count == 2 {
            return min(height[0], height[1])
        }
        var result = 0
        for idx in 0..<height.count {
            let value = height[idx]
            if value <= 0 { continue }
            let preferMax = value * (height.count - 1 - idx)
            if preferMax < result { continue }
            let minOffset = result / value
            for j in (idx + 1 ..< height.count).reversed() {
                let offset = j - idx
                if offset < minOffset { break }
                let rangeMax = value * offset
                if rangeMax <= result { break }
                if height[j] >= value {
                    result = rangeMax
                    break
                } else {
                    result = max(result, height[j] * offset)
                }
            }
        }
        return result
    }
}

// 双头指针法，取两头数值最小的*位移量和最大值做比较，然后移动数值小的那个指针
class Solution2: SolutionType {
    static func maxArea(_ height: [Int]) -> Int {
        guard height.count > 1 else {
            return 0
        }
        if height.count == 2 {
            return min(height[0], height[1])
        }
        var result = 0
        var head = 0
        var tail = height.count - 1
        while tail > head {
            if height[head] < height[tail] {
                result = max(result, height[head] * (tail - head))
                head += 1
            } else {
                result = max(result, height[tail] * (tail - head))
                tail -= 1
            }
        }
        return result
    }
}

Solution2.maxArea([1,8,6,2,5,4,8,3,7])
Solution2.maxArea([2,3,4,5,18,17,6])
