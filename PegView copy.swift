//
//  PegView.swift
//  Mastermind
//
//  Created by TJ Usiyan on 2017/01/23.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

import UIKit

class PegView: UIView {
    var color: Color? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let fullRect = CGRect(origin: .zero, size: bounds.size)
        context.saveGState()
        defer { context.restoreGState() }
        context.clear(fullRect)

        guard let _color = color else {
            return
        }

        let path = UIBezierPath()
        path.move(to: fullRect.midXminY)
        path.addCurve(to: fullRect.maxXmidY, controlPoint1: fullRect.maxXminY, controlPoint2: fullRect.maxXminY)
        path.addCurve(to: fullRect.midXmaxY, controlPoint1: fullRect.maxXmaxY, controlPoint2: fullRect.maxXmaxY)
        path.addCurve(to: fullRect.minXmidY, controlPoint1: fullRect.minXmaxY, controlPoint2: fullRect.minXmaxY)
        path.addCurve(to: fullRect.midXminY, controlPoint1: fullRect.minXMinY, controlPoint2: fullRect.minXMinY)
        context.setFillColor(_color.cgColor)
        path.fill()


    }


}//Peg view is also defining graphics to display, but does not appear to be implemented yet.

extension CGRect {
    var minXMinY: CGPoint {
        return CGPoint(x: minX, y: minY)
    }
    var minXmaxY: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    var maxXmaxY: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }
    var maxXminY: CGPoint {
        return CGPoint(x: maxX, y: minY)
    }

    var midXminY: CGPoint {
        return CGPoint(x: midX, y: minY)
    }
    var midXmaxY: CGPoint {
        return CGPoint(x: midX, y: maxY)
    }
    var minXmidY: CGPoint {
        return CGPoint(x: minX, y: midY)
    }
    var maxXmidY: CGPoint {
        return CGPoint(x: maxX, y: midY)
    }
    
}//This extension to CGRect declares points at each corner and in the middle of each side of the rectangle
