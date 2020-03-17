//
//  CanvasObject.swift
//  Blue-Husky-Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import Foundation



/// An object which can be placed on a canvas
public protocol CanvasObject: Drawable {
    
    /// A universally-unique identifier for this object. As this object is changed, this identifier is not.
    var identifier: UUID { get }
    
    /// The shape of the object
    var bézierShape: BézierShape { get }
    
    /// How the object is locked, if at all
    var lock: Lock? { get }
    
    /// How the object is styled
    var style: Style { get }
    
    /// The positional offset of the object.
    /// Note that this compounds on top of the position of the curves in the `bézierShape`
    var position: CanvasPoint { get }
}



extension CanvasObject {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.identifier == rhs.identifier
    }
}



extension CanvasObject {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}



/// An object which can be placed on a canvas and manipulated
public protocol MutableCanvasObject: CanvasObject {
    var bézierShape: BézierShape { get set }
    var lock: Lock? { get set }
    var style: Style { get set }
    var position: CanvasPoint { get set }
}



public extension CanvasObject {
    /// The shape of the object
    var bezierShape: BezierShape { bézierShape }
}



public extension MutableCanvasObject {
    /// The shape of the object
    var bezierShape: BezierShape {
        get { bézierShape }
        set { bézierShape = newValue }
    }
}



/// A way in which a canvas object is locked
public enum CanvasObjectLock {
    
    /// The object has an aspect ratio lock;
    /// it can be moved freely, but, when resized, it must maintain this aspect ratio
    /// - Parameter ratio: The aspect ratio that must be maintained
    case aspectRatio(ratio: CanvasSize)
    
    /// The object has a height lock;
    /// it can be moved freely, and its width can be changed freely, but its height cannot change
    case height
    
    /// The object has a width lock;
    /// it can be moved freely, and its height can be changed freely, but its width cannot change
    case width
    
    /// The object has a size lock;
    /// it can be moved freely, but it cannot be resized
    case size
    
    /// The object has a total lock;
    /// it cannot be moved nor resized at all
    case total
}



public extension CanvasObject {
    typealias Lock = CanvasObjectLock
}
