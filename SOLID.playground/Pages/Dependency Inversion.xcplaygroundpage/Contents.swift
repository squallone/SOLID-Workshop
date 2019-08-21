//: [Previous](@previous)
/*:
 ## Dependency Inversion Principle
It tells us that the most flexible systems are those in which source code dependencies refer only to abstractions, not to concretions.
 
 “It is the volatile concrete elements of our system that we want to avoid depending on. Those are the modules that we are actively developing, and that are undergoing frequent change."
*/
import Foundation

final class Handler {
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func handle(string: String) {
        storage.write()
    }
}

protocol Storage {
    func write()
}

final class FilesystemManager: Storage {
    func write() {
      
    }
}

final class MemoryMock: Storage {
    func write() {
        // Handler string into memory
    }
}

let handler = Handler(storage: FilesystemManager())
let handlerTest = Handler(storage: MemoryMock())
//: ### Example 2

protocol TimeTraveling {
    func travelInTime(time: TimeInterval) -> String
}

final class DeLorean: TimeTraveling {
    func travelInTime(time: TimeInterval) -> String {
        return "Used Flux Capacitor and travelled in time by: \(time)s"
    }
}

final class EmmettBrown {
    private let timeMachine: TimeTraveling
    init(timeMachine: TimeTraveling) {
        self.timeMachine = timeMachine
    }
    
    func travelInTime(time: TimeInterval) -> String {
        return timeMachine.travelInTime(time: time)
    }
}

let timeMachine = DeLorean()

let mastermind = EmmettBrown(timeMachine: timeMachine)
mastermind.travelInTime(time: -3600 * 8760)

//: [Next](@next)
