//
//  Constants.swift
//  
//
//  Created by Ben Leggiero on 2020-02-24.
//

import Foundation
import CoreGraphics



public extension FloatingPoint where Self: ExpressibleByFloatLiteral {
    
    /// Calculates `kappa`, the ideal multiplier to apply to a Bézier control point when approximating a circular arc
    ///
    /// This will end up being like one of these:
    /// - `0.551915024494`
    ///
    /// See also:
    /// - https://stackoverflow.com/a/33672847/3939277
    @inline(__always)
    static func calculateBézierCircularArcMultiplier() -> Self {
        return 0.551915024494
    }
}



// MARK: - Concrete static caching

public extension Float32 {
    /// Also known as `kappa`: the ideal multiplier to apply to a Bézier control point when approximating a circular arc
    static let bézierCircularArcMultiplier = Self.calculateBézierCircularArcMultiplier()
}



public extension Float64 {
    /// Also known as `kappa`: the ideal multiplier to apply to a Bézier control point when approximating a circular arc
    static let bézierCircularArcMultiplier = Self.calculateBézierCircularArcMultiplier()
}



#if (arch(i386) || arch(x86_64)) && !os(Windows)
public extension Float80 {
    /// Also known as `kappa`: the ideal multiplier to apply to a Bézier control point when approximating a circular arc
    static let bézierCircularArcMultiplier = Self.calculateBézierCircularArcMultiplier()
}
#endif



public extension CGFloat {
    /// Also known as `kappa`: the ideal multiplier to apply to a Bézier control point when approximating a circular arc
    @inline(__always)
    static var bézierCircularArcMultiplier: CGFloat { CGFloat(NativeType.bézierCircularArcMultiplier) }
}
