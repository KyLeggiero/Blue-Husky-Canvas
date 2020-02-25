//
//  Canvas Limits.swift
//  
//
//  Created by Ben Leggiero on 2020-02-16.
//

import Foundation
import RectangleTools



public extension Canvas {
    struct Limits {
        public var top: Limit?
        public var right: Limit?
        public var bottom: Limit?
        public var left: Limit?
        
        
        public init(top: Limit? = nil,
                    right: Limit? = nil,
                    bottom: Limit? = nil,
                    left: Limit? = nil)
        {
            self.top = top
            self.right = right
            self.bottom = bottom
            self.left = left
        }
        
        
        public init(top: Limit?,
                    eachHorizontal: Limit?,
                    bottom: Limit?) {
            self.init(
                top: top,
                right: eachHorizontal,
                bottom: bottom,
                left: eachHorizontal
            )
        }
        
        
        public init(eachVertical: Limit?,
                    eachHorizontal: Limit?) {
            self.init(
                top: eachVertical,
                eachHorizontal: eachHorizontal,
                bottom: eachVertical
            )
        }
        
        
        public init(each: Limit?) {
            self.init(
                eachVertical: nil,
                eachHorizontal: nil
            )
        }
        
        
        public init(rectangle: CanvasRect) {
            self.init(
                top: .offset(pointsFromZero: rectangle.minY),
                right: .offset(pointsFromZero: rectangle.maxX),
                bottom: .offset(pointsFromZero: rectangle.minY),
                left: .offset(pointsFromZero: rectangle.minX)
            )
        }
        
        
        public init(origin: CanvasPoint = .zero,
                    size: CanvasSize) {
            self.init(rectangle: CanvasRect(origin: origin, size: size))
        }
    }
}



public extension Canvas {
    enum Limit {
        case offset(pointsFromZero: Length)
        
        
        
        public typealias Length = CGFloat
    }
}



extension Canvas.Limit: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Length.FloatLiteralType) {
        self = .offset(pointsFromZero: Length(floatLiteral: value))
    }
}



extension Canvas.Limit: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Length.IntegerLiteralType) {
        self = .offset(pointsFromZero: Length(integerLiteral: value))
    }
}
