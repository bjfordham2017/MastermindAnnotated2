//
//  CodeView.swift
//  Mastermind
//
//  Created by TJ Usiyan on 2017/01/20.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

import UIKit

class CodeView: UIView {
    var code: Code? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }
        let fullRect = CGRect(origin: .zero, size: bounds.size)
        context.saveGState()
        defer { context.restoreGState() }
        context.setFillColor(UIColor.darkGray.cgColor)
        context.fill(fullRect)

        guard let _code = code, _code.length == 4 else {
                return
        }


        let quarterHeight = fullRect.size.height * 0.25
        let eigthHeight = fullRect.size.height * 0.125
        let pegRadius: CGFloat = 25
        let centerX = fullRect.size.width * 0.5

        for i in 0..<4 {
            let iAsFloat = CGFloat(i)
            let pegCenter = CGPoint(x: centerX, y: eigthHeight + (quarterHeight * iAsFloat))
            let pegPath = UIBezierPath()
            pegPath.addArc(withCenter: pegCenter, radius: pegRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            UIColor.red.setFill()
            context.setFillColor(_code.value[i].cgColor)
            pegPath.fill()
        }
    }
}//This override function creates a dark grey rectangle that fills the view and four "pegs" in a verticle line in the center of the view, colored appropriately to each Color in the Code code.  It guards against a nil code or a code with a length other than four.


extension CGRect {
    public var center: CGPoint {
        return CGPoint(x: origin.x + (size.width * 0.5), y: origin.y + (size.height * 0.5))
    }
}//This extension to the core graphics rectangle gives a CGRect a center point calculated from the height, width, and origin of the rectangle

extension Color {
    var cgColor: CGColor {
        switch self {
        case .red:
            return UIColor.red.cgColor
        case .orange:
            return UIColor.orange.cgColor
        case .yellow:
            return UIColor.yellow.cgColor
        case .green:
            return UIColor.green.cgColor
        case .blue:
            return UIColor.blue.cgColor
        case .purple:
            return UIColor.purple.cgColor
        case .magenta:
            return UIColor.magenta.cgColor
        case .lightGrey:
            return UIColor.lightGray.cgColor
        }
    }
}//This extension to the Color type provides an actual color that can be associated with each case when their buttons are displayed onscreen.
