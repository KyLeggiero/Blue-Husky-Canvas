//
//  NativeBezierPath.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-24.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

#if canImport(UIKit)
import UIKit



typealias NativeBezierPath = UIBezierPath

#elseif canImport(AppKit)
import AppKit



typealias NativeBezierPath = NSBezierPath

#endif


