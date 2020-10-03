//
//  GenericizedCanvasObject.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-24.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation



/// A canvas object which is only what it needs to be, plus an object that it can convert into a `BézierShape`
public struct GenericizedCanvasObject<Base: BézierShapeConvertible> {
    
    /// The object that this canvas object represents
    public var base: Base
    
    public let identifier: UUID
    public var lock: Lock?
    public var style: Style
    public var position: CanvasPoint
    
    
    public init(
        base: Base,
        identifier: UUID = UUID(),
        lock: Lock?,
        style: Style,
        position: CanvasPoint
    ) {
        self.base = base
        self.identifier = identifier
        self.lock = lock
        self.style = style
        self.position = position
    }
}



extension GenericizedCanvasObject: CanvasObject {
    @inlinable
    public var bézierShape: BézierShape { base.bézierShape(at: position) }
}

