import Foundation

// Single Responsibility principle:
// A class has just *ONE* reason to change

class Journal: CustomStringConvertible {
    // Saving the journal entries is the responsibility of this Journal
    // class, so it makes sense to come back and modify it if the rules
    // of storing the entries change
    var entries = [String]()
    var count = 0

    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }

    func removeEntry(_ index: Int) {
        entries.remove(at: index)
    }

    var description: String {
        return entries.joined(separator: "\n")
    }

    // Add new functionality to the Journal class for persistence
    /* func save(_ filename: String, _ overwrite: Bool = false) {
        /// Save to a file
    }

    func load(_ filename: String) {}
    func load(_ uri: URI) {} */
    // This functionality breaks the Single Responsibility principle
    // A class should have only *ONE* reason to change, but now, everytime
    // the persistence rules change we need to modify the behavior of the
    // journal class
}

class Persistence {
    func save(_ journal: Journal, _ filename: String, _ overwrite: Bool = false) {
        /// Save to a file
    }
}

func main() {
    let j = Journal()

    let _ = j.addEntry("I did nothing today")
    let nothing = j.addEntry("I did nothing today again")
    print(j)

    j.removeEntry(nothing)
    print("======")
    print(j)

    //j.save("mnt/c/whatever.file")

    let p = Persistence()
    let filename = "mnt/c/whatever.file"

    p.save(j, filename, true)
}

main()