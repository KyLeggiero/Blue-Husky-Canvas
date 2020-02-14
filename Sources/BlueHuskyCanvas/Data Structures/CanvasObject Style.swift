//
//  CanvasObject Style.swift
//  Blue-Husky-Canvas
//
//  Created by Ben Leggiero on 2020-02-10.
//  Copyright © 2020 Ben Leggiero. All rights reserved.
//

import Foundation
import CrossKitTypes
import NonEmpty



public extension CanvasObject {
    typealias Style = CanvasObjectStyle
}



public struct CanvasObjectStyle {
    var fill: Fill?
    var stroke: Stroke?
    var shadow: Shadow?
}



public extension CanvasObjectStyle {
    struct Fill {
        var content: Content
        var approach: Approach
    }
}



public extension CanvasObjectStyle.Fill {
    enum Content {
        case solid(color: NativeColor)
        case image(image: NativeImage)
//        case linearGradient(gradient: LinearGradient)
//        case radialGradient(gradeitn: RadialGradient)
    }
}



public extension CanvasObjectStyle.Fill {
    enum Approach {
        case always
        case evenOdd
    }
}



public extension CanvasObjectStyle {
    struct Stroke {
        var style: Style
        var fill: Fill
        var thickness: CGFloat
    }
}



public extension CanvasObjectStyle.Stroke {
    enum Style {
        case solid
        case dashed(phases: NonEmptyArray<DashPhase>)
        case dotted(gaps: NonEmptyArray<CGFloat>)
    }
}



public extension CanvasObjectStyle.Stroke {
    public struct DashPhase {
        var precedingGap: CGFlaot
        var solidLength: CGFloat
    }
}



public extension CanvasObjectStyle {
    public struct Shadow {
        var color: NativeColor
        var offset: CGPoint
        var blur: CGFloat
    }
}
