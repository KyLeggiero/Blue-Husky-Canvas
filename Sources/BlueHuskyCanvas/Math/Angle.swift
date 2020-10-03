//
//  Angle.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-24.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation
import CoreGraphics



public struct Angle {
    public var unit: Unit
    public var value: CanvasLength
    
    
    public init(unit: Unit, value: CanvasLength) {
        self.unit = unit
        self.value = value
    }
}



public extension Angle {
    enum Unit {
        case degrees
        case radians
        case revolutions
    }
}



public extension Angle {
    static func degrees(_ value: CanvasLength) -> Angle { .init(unit: .degrees, value: value) }
    static func radians(_ value: CanvasLength) -> Angle { .init(unit: .radians, value: value) }
    static func revolutions(_ value: CanvasLength) -> Angle { .init(unit: .revolutions, value: value) }
}



public extension Angle {
    func converted(to otherUnit: Unit) -> Angle {
        guard unit != otherUnit else {
            return self
        }
        
        return Angle(unit: otherUnit,
                     value: CanvasLength(measurement
                        .converted(to: otherUnit.forMeasurement)
                        .value)
        )
    }
    
    
    var measurement: Measurement<UnitAngle> {
        Measurement(value: Double(value), unit: unit.forMeasurement)
    }
}



public extension Angle.Unit {
    
    var forMeasurement: UnitAngle {
        switch self {
        case .degrees: return .degrees
        case .radians: return .radians
        case .revolutions: return .revolutions
        }
    }
}
