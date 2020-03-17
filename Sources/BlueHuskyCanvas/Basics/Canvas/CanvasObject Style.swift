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



public struct CanvasObjectStyle: Equatable {
    public var fill: Fill?
    public var stroke: Stroke?
//    public var shadow: Shadow?
    
    
    public init(fill: Fill?, stroke: Stroke?) {
        self.fill = fill
        self.stroke = stroke
    }
}



public extension CanvasObjectStyle {
    struct Fill: Equatable {
        public var content: Content
        public var approach: Approach
        
        public init(content: Content, approach: Approach) {
            self.content = content
            self.approach = approach
        }
    }
}



public extension CanvasObjectStyle.Fill {
    enum Content: Equatable {
        case solid(color: NativeColor)
//        case image(image: NativeImage)
//        case linearGradient(gradient: LinearGradient)
//        case radialGradient(gradeitn: RadialGradient)
//        case custom(drawable: Drawable)
    }
}



public extension CanvasObjectStyle.Fill {
    enum Approach: Equatable {
        case always
        case evenOdd
    }
}



public extension CanvasObjectStyle {
    struct Stroke: Equatable {
        public var style: Style
        public var content: Fill.Content
        public var thickness: CGFloat
        
        
        public init(
            style: Style,
            content: Fill.Content,
            thickness: CGFloat
        ) {
            self.style = style
            self.content = content
            self.thickness = thickness
        }
    }
}



public extension CanvasObjectStyle.Stroke {
    enum Style: Equatable {
        case solid
//        case dashed(phases: NonEmptyArray<DashPhase>)
//        case dotted(gaps: NonEmptyArray<CGFloat>)
    }
}



public extension CanvasObjectStyle.Stroke {
    struct DashPhase: Equatable {
        public var precedingGap: CGFloat
        public var solidLength: CGFloat
        
        
        public init (
            precedingGap: CGFloat,
            solidLength: CGFloat
        ) {
            self.precedingGap = precedingGap
            self.solidLength = solidLength
        }
    }
}



public extension CanvasObjectStyle {
    struct Shadow: Equatable {
        public var color: NativeColor
        public var offset: CanvasPoint
        public var blur: CGFloat
        
        
        public init(
            color: NativeColor,
            offset: CanvasPoint,
            blur: CGFloat
        ) {
            self.color = color
            self.offset = offset
            self.blur = blur
        }
    }
}
