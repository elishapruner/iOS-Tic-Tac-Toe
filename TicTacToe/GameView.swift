//
//  GameView.swift
//  TicTacToe
//
//  Created by Elisha Pruner on 2017-06-13.
//  Copyright © 2017 Elisha Pruner. All rights reserved.
//

import UIKit

protocol GameViewDelegate {
    func cellSelected(col: Int, row: Int)
}

class GameView: UIView {
    
    private var _gridRect: CGRect = CGRect.zero
    
    // MARK: - UIResponder Overrides
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: self)
        let gridPoint: CGPoint = CGPoint(x: touchPoint.x - _gridRect.minX, y: touchPoint.y - _gridRect.minY)
        
        if gridPoint.x >= 0.0 && gridPoint.x < _gridRect.width && gridPoint.y >= 0.0 && gridPoint.y < _gridRect.height {
            let selectedCol: Int = Int(floor(Double(gridPoint.x) / (Double(_gridRect.width * 0.333))))
            let selectedRow: Int = Int(floor(Double(gridPoint.y) / (Double(_gridRect.height * 0.333))))
            delegate?.cellSelected(col: selectedCol, row: selectedRow)
        }
        
    }
    
    // MARK: - UIView Overrides
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Calculate grid rect
        let dimension: CGFloat = min(bounds.width, bounds.height)
        _gridRect.size.width = dimension
        _gridRect.size.height = dimension
        
        if (bounds.width < bounds.height) {
            _gridRect.origin.x = 0.0
            _gridRect.origin.y = bounds.height * 0.5 - _gridRect.size.height * 0.5
        } else {
            _gridRect.origin.x = bounds.width * 0.5 - _gridRect.size.width * 0.5
            _gridRect.origin.y = 0.0
        }
        
        
        // DEGUB: Fill so we can see the rect
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.addRect(_gridRect)
        context.setFillColor(UIColor.green.cgColor)
        context.drawPath(using: .fill)
        
        
        // Draw grid lines
        context.setLineWidth(dimension * 0.01)
        context.setStrokeColor(UIColor.darkGray.cgColor)
        
        context.move(to: CGPoint(x: _gridRect.minX + _gridRect.width * 0.333, y: _gridRect.minY))
        context.addLine(to: CGPoint(x: _gridRect.minX + _gridRect.width * 0.333, y: _gridRect.maxY))
        context.drawPath(using: .stroke)
        
        context.move(to: CGPoint(x: _gridRect.minX + _gridRect.width * 0.666, y: _gridRect.minY))
        context.addLine(to: CGPoint(x: _gridRect.minX + _gridRect.width * 0.666, y: _gridRect.maxY))
        context.drawPath(using: .stroke)
        
        context.move(to: CGPoint(x: _gridRect.minX, y: _gridRect.minY + _gridRect.height * 0.333))
        context.addLine(to: CGPoint(x: _gridRect.maxX, y: _gridRect.minY + _gridRect.height * 0.333))
        context.drawPath(using: .stroke)
        
        context.move(to: CGPoint(x: _gridRect.minX, y: _gridRect.minY + _gridRect.height * 0.666))
        context.addLine(to: CGPoint(x: _gridRect.maxX, y: _gridRect.minY + _gridRect.height * 0.666))
        context.drawPath(using: .stroke)
        
        
        // Draw game tokens
        for tokenIndex: Int in 0 ..< min(9, tokens.count) {
            let token: NSString = tokens[tokenIndex] as NSString
            let tokenCol: Int = tokenIndex % 3
            let tokenRow: Int = tokenIndex / 3
            
            var tokenRect: CGRect = CGRect.zero
            tokenRect.size.width = _gridRect.width * 0.333
            tokenRect.size.height = _gridRect.height * 0.333
            tokenRect.origin.x = _gridRect.minX + tokenRect.width * CGFloat(tokenCol)
            tokenRect.origin.y = _gridRect.minY + tokenRect.height * CGFloat(tokenRow)
            
            let tokenTextAttributes: [String: Any] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: dimension * 0.2)]
            let tokenSize: CGSize = token.size(attributes: tokenTextAttributes)
            token.draw(at: CGPoint(x: tokenRect.midX - tokenSize.width * 0.5, y: tokenRect.midY - tokenSize.height * 0.5), withAttributes: tokenTextAttributes)
        }
        
    }
    
    
    // MARK: - GameView Elements
    public var delegate: GameViewDelegate? = nil
    
    public var tokens: [String] = ["", "", "", "", "", "", "", "", "", ] {
        didSet {
            setNeedsDisplay()
        }
    }
}
