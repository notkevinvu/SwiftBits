import UIKit

/** A Heap that makes use of generics and can be initialized as a min- or max-heap. */
public struct Heap<T> {
    
    // MARK: - Properties
    /** The array that stores the heap's nodes. */
    var nodes = [T]()
    
    /**
     * Determines how to compare two nodes in the heap.
     * Use `>` for a max-heap or `<` for a min-heap,
     * or provide a comparing method if the heap is made
     * of custom elements, for example tuples.
     */
    private var orderCriteria: (T, T) -> Bool
    
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    public var count: Int {
        return nodes.count
    }
    
    
    // MARK: - Init
    /**
     * Creates an empty heap.
     * The sort function determines whether this is a min- or max-heap.
     * For comparable data types, `>` makes a max-heap, `<` makes a min-heap.
     */
    public init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    /**
     * Configures the max- or min-heap from an array, in a bottom-up manner.
     * Performance: This runs pretty much in O(n).
     */
    private mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
            heapifyDown(i)
        }
    }
    
}


extension Heap {
    // MARK: - Parent/child helper methods
    // get indices
    private func getLeftChildIndex(forIndex i: Int) -> Int { return 2 * i + 1 }
    private func getRightChildIndex(forIndex i: Int) -> Int { return 2 * i + 2 }
    private func getParentIndex(forIndex i: Int) -> Int { return (i - 1) / 2 }
    
    // checks for parent/children
    private func hasLeftChild(_ index: Int) -> Bool {
        return getLeftChildIndex(forIndex: index) < nodes.count
    }
    private func hasRightChild(_ index: Int) -> Bool {
        return getRightChildIndex(forIndex: index) > nodes.count
    }
    private func hasParent(_ index: Int) -> Bool {
        return getParentIndex(forIndex: index) >= 0
    }
    
    // gets the value for parent/children
    private func leftChild(forIndex i: Int) -> T {
        return nodes[getLeftChildIndex(forIndex: i)]
    }
    private func rightChild(forIndex i: Int) -> T {
        return nodes[getRightChildIndex(forIndex: i)]
    }
    private func parent(forIndex i: Int) -> T {
        return nodes[getParentIndex(forIndex: i)]
    }
    
    
    // MARK: - Public methods
    public func peek() -> T? {
        return nodes.first
    }
    
    /**
     * Removes and returns the root node from the heap. For a max-heap, this is the maximum
     * value; for a min-heap, this is the minimum value. Performance: O(log n).
     */
    @discardableResult public mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            // use the last node to replace the first one, then the heap by
            // shifting this new first node into its proper position
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            heapifyDown(0)
            return value
        }
    }
    
    
    /**
     * Removes an arbitrary node from the heap. Performance: O(log n).
     * Note that you need to know the node's index.
     */
    @discardableResult public mutating func remove(at index: Int) -> T? {
        guard index < nodes.count else { return nil }
        
        let size = nodes.count - 1
        if index != size {
            nodes.swapAt(index, size)
            heapifyDown(from: index, until: size)
            heapifyUp(index)
        }
        
        return nodes.removeLast()
    }
    
    /**
     * Adds a new value to the heap and reoders the heap so that the max- or min-heap property still holds.
     * Performance O(log n).
     */
    public mutating func add(_ value: T) {
        nodes.append(value)
        heapifyUp(nodes.count - 1)
    }
    
    /**
     * Adds a sequence of values to the heap and reorders the heap so that the max- or min-heap property
     * still holds. Performance: O(log n).
     */
    public mutating func add<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for value in sequence {
            add(value)
        }
    }
    
    
    /**
     * Takes a child node and looks at its parents; if a parent is not larger (max-heap) or not smaller
     * (min-heap) than the child, we exchange them
     */
    internal mutating func heapifyUp(_ index: Int) {
        var childIndex = index
        
        while hasParent(childIndex) && orderCriteria(nodes[childIndex], parent(forIndex: childIndex)) {
            nodes.swapAt(getParentIndex(forIndex: childIndex), childIndex)
            childIndex = getParentIndex(forIndex: childIndex)
        }
    }
    
    
    /**
     * Looks at a parent node and makes sure it is still larger (max-heap) or smaller (min-heap)
     * than its children
     */
    internal mutating func heapifyDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = getLeftChildIndex(forIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        // Figure out which comes first if we order them by the sort function:
        // the parent, the left child, or the right child. If the parent comes
        // first, we're done. If not, that element is out-of-place and we make
        // it "float down" the tree until the heap property is restored.
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        
        if first == index { return }
        
        nodes.swapAt(index, first)
        heapifyDown(from: first, until: endIndex)
    }
    
    internal mutating func heapifyDown(_ index: Int) {
        heapifyDown(from: index, until: nodes.count)
    }
}


// MARK: - Searching
extension Heap where T: Equatable {
    
    /// Get the index of a node in the heap. Performance: O(n)
    public func index(of node: T) -> Int? {
        return nodes.firstIndex(where: { $0 == node } )
    }
    
    @discardableResult public mutating func remove(node: T) -> T? {
        if let index = index(of: node) {
            return remove(at: index)
        }
        return nil
    }
}
