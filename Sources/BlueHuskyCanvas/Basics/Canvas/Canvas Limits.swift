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
        public var trailing: Limit?
        public var bottom: Limit?
        public var leading: Limit?
        
        
        public init(top: Limit? = nil,
                    trailing: Limit? = nil,
                    bottom: Limit? = nil,
                    leading: Limit? = nil)
        {
            self.top = top
            self.trailing = trailing
            self.bottom = bottom
            self.leading = leading
        }
        
        
        public init(top: Limit?,
                    eachHorizontal: Limit?,
                    bottom: Limit?) {
            self.init(
                top: top,
                trailing: eachHorizontal,
                bottom: bottom,
                leading: eachHorizontal
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
    }
}



public extension Canvas {
    enum Limit {
        case offset(pointsFromZero: Length)
        
        
        
        public typealias Length = CGFloat
    }
}
