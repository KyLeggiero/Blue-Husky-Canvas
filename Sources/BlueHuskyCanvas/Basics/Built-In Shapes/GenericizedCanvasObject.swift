//
//  GenericizedCanvasObject.swift
//  
//
//  Created by Ben Leggiero on 2020-02-24.
//

import Foundation



/// A canvas object which is only what it needs to be, plus an object that it can convert into a `BézierShape`
public struct GenericizedCanvasObject<Base: BézierShapeConvertible> {
    
    /// The object that this canvas object represents
    public var base: Base
    
    public var lock: Lock?
    public var style: Style
    public var position: CGRect
    
    
    public init(
        base: Base,
        lock: Lock?,
        style: Style,
        position: CGRect
    ) {
        self.base = base
        self.lock = lock
        self.style = style
        self.position = position
    }
}



extension GenericizedCanvasObject: CanvasObject {
    public var bézierShape: BézierShape { base.bézierShape() }
}

