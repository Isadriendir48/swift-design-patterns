import Foundation

class Rectangle: CustomStringConvertible {
    var _width = 0
    var _height = 0

    var width: Int {
        get { return _width }
        set(value) { self._width = value }
    }

    var height: Int {
        get { return _height }
        set(value) { self._height = value }
    }

    init() {}
    init(_ width: Int, _ height: Int) {
        self._width = width
        self._height = height
    }

    var area: Int {
        return width * height
    }

    var description: String {
        return "Width: \(width), height: \(height)"
    }
}

// This breaks the substitution principle, as the
// behavior of the base class is modified
class Square: Rectangle {
    override var width: Int {
        get { return _width }
        set(value) { 
            self._width = value
            self._height = value
         }
    }

    override var height: Int {
        get { return _height }
        set(value) { 
            self._height = value
            self._width = value
         }
    }
}

// Any behavior defined for a base class should apply to all
// their subclass implementations
func setAndMeasure(_ rectangle: Rectangle) {
    rectangle.width = 3
    rectangle.height = 4

    print("Expected area: 12, actual area: \(rectangle.area)")
    
}

func main() {
    let rc = Rectangle()
    setAndMeasure(rc)

    let sq = Square()
    setAndMeasure(sq)
}

main()