//
//  Drawable.swift
//  
//
//  Created by Ben Leggiero on 2020-02-17.
//

import Foundation
import CrossKitTypes
import CoreGraphics



/// Something which can be drawn in two dimensions
public protocol Drawable {
    /// Draws this object immediately
    ///
    /// - Parameters:
    ///   - context:     The context in which to draw this object
    ///   - targetSize:  The ideal size of the output image, in points. That is, in a "Retina 2X" environment, a
    ///                  `targetSize` of `2x2` will have `4x4` pixels
    ///   - environment: Some notes about the environment in which the object will be drawn
    func draw(in context: CGContext, targetSize: CGSize, environment: Environment)
}



// MARK: - DrawableEnvironment

/// The environment in which something will be drawn
public struct DrawingEnvironment {
    /// The multiplier for the output DPI.
    public var dpiMultiplier: DpiMultiplier
    
    
    public init(dpiMultiplier: DpiMultiplier) {
        self.dpiMultiplier = dpiMultiplier
    }
}



public extension Drawable {
    /// The environment in which something will be drawn
    typealias Environment = DrawingEnvironment
}



// MARK: DpiMultiplier

public extension DrawingEnvironment {
    
    /// The multiplier for some output DPI.
    ///
    /// For instance, an Apple Mac's "Retina Display" targets 2x the resolution of a 96DPI display of the same size,
    /// but then scales up everything by 2x so everything is the same physical size as it would be on an equivalent
    /// 96DPI display. This would be represented as `retina2x`.
    enum DpiMultiplier {
        
        /// The DPI of the output is the same as a traditional display (1-to-1)
        case native
        
        /// The DPI of the output is twice that of a traditional display (2-to-1)
        case retina2x
        
        /// The DPI of the output is three times that of a traditional display (3-to-1)
        case retina3x
        
        /// The DPI of the output is some amount more or less than that of a traditional display (_n_-to-1)
        ///
        /// - Parameter multiplier: The multiplier against the DPI of a traditional display. For instance, if a display
        ///                         is 1.5 more pixel-dense than a traditional display of the same size, this would be
        ///                         `1.5`. If it's half as dense, this would be `0.5`.
        case other(multiplier: CGFloat)
    }
}



extension DrawingEnvironment.DpiMultiplier: ExpressibleByFloatLiteral {
    
    public typealias FloatLiteralType = RawValue.FloatLiteralType
    
    
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(rawValue: RawValue(value))
    }
}



extension DrawingEnvironment.DpiMultiplier: RawRepresentable {
    
    public typealias RawValue = CGFloat
    
    
    
    public init(rawValue: Self.RawValue) {
        switch rawValue {
        case 1:  self = .native
        case 2:  self = .retina2x
        case 3:  self = .retina3x
        default: self = .other(multiplier: rawValue)
        }
    }
    
    
    public var rawValue: RawValue {
        switch self {
        case .native:   return 1
        case .retina2x: return 2
        case .retina3x: return 3
        case .other(let multiplier): return multiplier
        }
    }
}
