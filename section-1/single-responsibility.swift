import Foundation

class Journal: CustomStringConvertible {
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
}

func main() {
    let j = Journal()

    let _ = j.addEntry("I did nothing today")
    let nothing = j.addEntry("I did nothing today again")

    print(j)

    j.removeEntry(nothing)

    print("======")
    print(j)
}

main()