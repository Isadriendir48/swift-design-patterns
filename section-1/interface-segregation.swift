import Foundation

class Document {

}

// Protocol requires too excesive functionality
// not all implementors need to use all functionality
protocol Machine {
    func print(d: Document)
    func scan(d: Document)
    func fax(d: Document)
}

// We can divide the protocol into smaller pieces, so we can
// implement the functionalities when needed 
protocol Printer {
    func print(d: Document)
}

protocol Scanner {
    func scan(d: Document)
}

protocol Fax {
    func fax(d: Document)
}

//class MultifunctionPrinter: Machine {
class MultifunctionPrinter: Printer, Scanner, Fax {
    func print(d: Document) {
        
    }

    func scan(d: Document) {
        
    }

    func fax(d: Document) {
        
    }
}

// We no longer need to implement overhead for 
// not supported functions on the devices
//enum NotSupportedFunctionError: Error  {
//    case doesNotFax
//}

//class ClassicPrinter: Machine {
class ClassicPrinter: Printer {
    func print(d: Document) {
        
    }

//    func scan(d: Document) {
//        throw NotSupportedFunctionError.doesNotFax
//    }

//    func fax(d: Document) {
//        
//    }
}

class Photocopier: Scanner, Printer {
    func scan(d: Document) {
        
    }

    func print(d: Document) {
        
    }
}

// We can merge multiple protocols through inheritance
protocol MultifunctionDevice: Printer, Scanner, Fax {}

class MultifunctionMachine: MultifunctionDevice {
    // Assuming we already have objects from the individual protocols,
    // we can pass those objects to our new class and implement
    // functionality using them
    let printer: Printer
    let scanner: Scanner

    init(printer: Printer, scanner: Scanner) {
        self.printer = printer
        self.scanner = scanner
    }
    
    func print(d: Document) {
        self.printer.print(d: d) // Base for the decorator pattern
    }

    func scan(d: Document) {
        
    }

    func fax(d: Document) {
        
    }


}