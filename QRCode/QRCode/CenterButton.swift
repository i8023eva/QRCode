//
//  CenterButton.swift
//  QRCode
//
//  Created by 李元华 on 2019/5/13.
//  Copyright © 2019 李元华. All rights reserved.
//

import Cocoa

class CenterButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let path = NSBezierPath(rect: dirtyRect)
        path.lineWidth = 3.0
        NSColor.red.set()
        path.stroke()
        path.close()
    }
    
}
