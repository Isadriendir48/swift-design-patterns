import Foundation

// Open - Closed principle:
// A class should be *open* for extension, but *closed* for modification

enum Color {
    case red
    case green
    case blue
}

enum Size {
    case small
    case medium
    case large
    case yuge
}

class Product {
    var name: String
    var color: Color
    var size: Size

    init(_ name: String, _ color: Color, _ size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
}

class ProductFilter {
    func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
        var result = [Product]()

        for p in products {
            if p.color == color {
                result.append(p)
            }
        }

        return result
    }
    
    // As new business rules are defined, the class is being modified
    func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
        var result = [Product]()

        for p in products {
            if p.size == size {
                result.append(p)
            }
        }

        return result
    }

    // We break the principle by modifying the class with each new requirement
    // instead of extending it without modifying the original
    func filterBySizeAndColor(_ products: [Product], _ size: Size, _ color: Color) -> [Product] {
        var result = [Product]()

        for p in products {
            if (p.size == size) && (p.color == color) {
                result.append(p)
            }
        }

        return result
    }
}

// Specification pattern
protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T]
        where Spec.T == T;
}

// The principle allows to close the system for modifications, but
// enabling extension of functionality (via inheritance in this case)
// to add new functionality without modifying the underlying constructs
class ColorSpecification: Specification {
    typealias T = Product

    let color: Color
    init(_ color: Color) {
        self.color = color
    }

    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product

    let size: Size
    init(_ size: Size) {
        self.size = size
    }

    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<
    T,
    SpecA: Specification,
    SpecB: Specification>: Specification
    where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T 
{
    let first: SpecA
    let second: SpecB

    init(_ first: SpecA, _ second: SpecB) {
        self.first = first
        self.second = second
    }

    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class BetterFilter: Filter {
    typealias T = Product

    func filter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [T] where Spec.T == T {
        var result = [Product]()
        for i in items {
            if spec.isSatisfied(i) {
                result.append(i)
            }
        }

        return result
    }
}

func main() {
    let apple = Product("Apple", .green, .small)
    let tree = Product("Tree", .green, .large)
    let house = Product("House", .blue, .large)

    let products = [apple, tree, house]

    let pf = ProductFilter()
    print("Green products (old):")
    for p in pf.filterByColor(products, .green) {
        print("\t-\(p.name) is green")
    }

    let bf = BetterFilter()
    print("Green products (new):")
    for p in bf.filter(products, ColorSpecification(.green)) {
        print("\t-\(p.name) is green")
    }
    
    print("Large products:")
    for p in bf.filter(products, SizeSpecification(.large)) {
        print("\t-\(p.name) is large")
    }
    
    print("Large, blue products:")
    for p in bf.filter(
        products, AndSpecification(
            SizeSpecification(.large), ColorSpecification(.blue)
        )
    ) {
        print("\t-\(p.name) is large AND blue")
    }
}

main()