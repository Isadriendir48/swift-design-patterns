import Foundation

// High level modules should not depend on low level modules
// Abstractions should not depend on details

enum Relationship {
    case parent
    case child
    case sibling
}

class Person {
    var name = ""
    init(_ name: String) {
        self.name = name
    }
}

protocol RelationshipBrowser {
    func findAllChildren(_ name: String) -> [Person]
}

class Relationships: RelationshipBrowser { // Low-level module
    private var relations = [(Person, Relationship, Person)]()

    func addParentAndChild(_ p: Person, _ c: Person) {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }

    // We introduce an abstraction for the actual implementation
    func findAllChildren(_ name: String) -> [Person] {
        return relations
        .filter { parent, relation, _ in
            parent.name == name && relation == .parent
        }
        .map { _, _, child in
            child
        }
    }
}

class Research { // High-level module

    // // Error 1: High-level module depends directly on low-level module
    // init(_ rel: Relationships) {
    //     let relations = rel.relations
    //     for r in relations 
    //         // Error 2: Abstraction depends on specific internals
    //         where r.0.name == "John"
    //         && r.1 == .parent
    //     {
    //         print("John has a child called \(r.2.name)")
    //     }
    // }

    // We change our implementation to work with the introduced abstraction
    init(_ browser: RelationshipBrowser) {
        for p in browser.findAllChildren("John") {
            print("John has a child named \(p.name)")
        }
    }
}

func main() {
    let parent = Person("John")
    let child1 = Person("Chris")
    let child2 = Person("Matt")

    let rels = Relationships()

    rels.addParentAndChild(parent, child1)
    rels.addParentAndChild(parent, child2)

    let _ = Research(rels)
}

main()