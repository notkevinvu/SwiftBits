import UIKit

let exampleArray = [1, 2, 3, 4, 5]
// this ordered set is just initialized like this for use without a core data class
// normally, you would have the CD class and add child attributes/classes to that set
var coreDataClassOrderedSet = NSOrderedSet(array: exampleArray)

print(coreDataClassOrderedSet) // should print {(1, 2, 3, 4, 5)}

let sourceIndex = 4
let destinationIndex = 0

// move object at index 4
let objectIndexToMove = IndexSet(integer: sourceIndex)

let mutableSet = NSMutableOrderedSet(array: coreDataClassOrderedSet.array)

mutableSet.moveObjects(at: objectIndexToMove, to: destinationIndex)

coreDataClassOrderedSet = mutableSet
print(coreDataClassOrderedSet) // should now print {(5, 1, 2, 3, 4)}
