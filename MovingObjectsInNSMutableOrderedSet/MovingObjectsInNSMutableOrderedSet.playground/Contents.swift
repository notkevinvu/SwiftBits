import UIKit


// move object at index 4
let objectIndexToMove = IndexSet(integer: 4)


let mySet = NSMutableOrderedSet()
mySet.add("a")
mySet.add("b")
mySet.add("c")
mySet.add("d")
mySet.add("e")
print(mySet) // should print {(a, b, c, d, e)}


mySet.moveObjects(at: objectIndexToMove, to: 0)
print(mySet)
// should now print {(e, a, b, c, d)}

