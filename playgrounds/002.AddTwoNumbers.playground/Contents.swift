/** Add Two Numbers
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
 
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Example:
 
     Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
     Output: 7 -> 0 -> 8
     Explanation: 342 + 465 = 807.
 */
protocol SolutionType {
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode?
}

/// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/// Some helper methods.
extension ListNode {
    var value: String {
        if let n = next {
            return String(val) + " -> " + n.value
        } else {
            return String(val)
        }
    }
    static func reverse(node: ListNode) -> ListNode {
        var current = node
        var previous: ListNode? = nil
        while let next = current.next {
            current.next = previous
            previous = current
            current = next
        }
        current.next = previous
        return current
    }
    static func construct(value: Int) -> ListNode {
        guard value > 10 else {
            return ListNode(value)
        }
        var node  = ListNode(value % 10)
        var v = value / 10
        var i = v % 10
        while v > 0 {
            let n = ListNode(i)
            v /= 10
            i = v % 10
            n.next = node
            node = n
        }
        return node
    }
}

/// 普通循环
enum Solution1: SolutionType {
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var num = (l1?.val ?? 0) + (l2?.val ?? 0)
        var overflow = num / 10
        l1?.val = num % 10
        var result: ListNode? = l1
        var l1Next = l1?.next
        var l2Next = l2?.next
        while let n1 = l1Next, let n2 = l2Next {
            l1Next = n1.next
            l2Next = n2.next
            num = n1.val + n2.val + overflow
            overflow = num / 10
            n1.val = num % 10
            result = n1
        }
        var next = l1Next ?? l2Next
        result?.next = next
        while let current = next {
            next = current.next
            num = overflow + current.val
            overflow = num / 10
            current.val = num % 10
            result = current
        }
        if overflow > 0 {
            result?.next = ListNode(overflow)
        }
        return l1
    }
}

/// 递归的版本
enum Solution2: SolutionType {
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        switch (l1, l2) {
        case (nil, nil):
            return nil
        case (let .some(l1), nil):
            return l1
        case (nil, let .some(l2)):
            return l2
        case (let .some(n1), let .some(n2)):
            var value = n1.val + n2.val
            if value < 10 {
                n1.val = value
                n1.next = addTwoNumbers(n1.next, n2.next)
                return n1
            } else {
                n1.val = value % 10
                var overflow = value / 10
                var current = n1
                n1.next = addTwoNumbers(n1.next, n2.next)
                while let next = current.next, overflow > 0 {
                    value = next.val + overflow
                    overflow = value / 10
                    next.val = value % 10
                    current = next
                }
                if overflow > 0 {
                    current.next = ListNode(overflow)
                }
                return n1
            }
        }
    }
}


let x1 = ListNode.reverse(node: ListNode.construct(value: 342))
let x2 = ListNode.reverse(node: ListNode.construct(value: 465))
x1.value
x2.value
Solution1.addTwoNumbers(x1, x2)?.value



