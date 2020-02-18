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
        
        
        init(top: Limit? = nil,
            trailing: Limit? = nil,
            bottom: Limit? = nil,
            leading: Limit? = nil)
        {
            self.top = top
            self.trailing = trailing
            self.bottom = bottom
            self.leading = leading
        }
        
        
        init(top: Limit? = nil,
             eachHorizontal: Limit? = nil,
             bottom: Limit? = nil) {
            self.init(
                top: top,
                trailing: eachHorizontal,
                bottom: bottom,
                leading: eachHorizontal
            )
        }
        
        
        init(eachVertical: Limit? = nil,
             eachHorizontal: Limit? = nil) {
            self.init(
                top: eachVertical,
                eachHorizontal: eachHorizontal,
                bottom: eachVertical
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
