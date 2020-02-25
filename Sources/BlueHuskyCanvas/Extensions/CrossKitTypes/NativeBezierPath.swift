//
//  NativeBezierPath.swift
//  
//
//  Created by Ben Leggiero on 2020-02-24.
//

#if canImport(UIKit)
import UIKit



typealias NativeBezierPath = UIBezierPath

#elseif canImport(AppKit)
import AppKit



typealias NativeBezierPath = NSBezierPath

#endif


