//
//  NonEmpty + Strideable Index.swift
//  Blue Husky Canvas
//
//  Created by Ben Leggiero on 2020-02-23.
//  Copyright © 2020 Ben Leggiero BH-1-PS
//

import Foundation
import NonEmpty



extension NonEmpty.Index: Strideable
    where
        C.Index: Strideable,
        C.Index: ExpressibleByIntegerLiteral
{
    
    public typealias Stride = C.Index.Stride
    
    
    
    public func distance(to other: NonEmpty<C>.Index) -> Stride {
        switch (self, other) {
        case (.head, .head):
            return 0
            
        case (.head, .tail(let tailIndex)):
            return tailIndex.distance(to: 0) + 1
            
        case (.tail(let tailIndex), .head):
            return -(tailIndex.distance(to: 0) + 1)
            
        case (.tail(let selfTailIndex), .tail(let otherTailIndex)):
            return selfTailIndex.distance(to: otherTailIndex)
        }
    }
    
    
    public func advanced(by stride: Stride) -> NonEmpty<C>.Index {
        switch (self, stride) {
        case (_, 0):
            return self
            
        case (.head, 1...):
            return .tail(
                (0 as C.Index)
                    .advanced(by: stride)
                    .advanced(by: 1)
            )
            
        case (.head, _):
            assertionFailure("Invalid stride: \(stride)")
            return .head
            
        case (.tail(let index), _):
            let advancedIndex = index.advanced(by: stride)
            
            switch advancedIndex {
            case 0:
                return .head
                
            case 1...:
                return .tail(advancedIndex.advanced(by: -1))
                
            default:
                assertionFailure("Invalid stride: \(stride)")
                return .tail(advancedIndex.advanced(by: -1))
            }
        }
    }
}
