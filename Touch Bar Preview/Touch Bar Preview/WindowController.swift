//
//  WindowController.swift
//  Touch Bar Preview
//
//  This Software is released under the MIT License
//
//  Copyright (c) 2017 Alexander Käßner
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  For more information see: https://github.com/touchbar/Touch-Bar-Preview
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet var touchBarImageView: NSImageView!
    @IBOutlet weak var emptyLabel: NSTextField!
    
    @IBOutlet weak var imageViewSpaceConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        if let ddvc: ViewController = self.window?.contentViewController as? ViewController {
            ddvc.windowDelegate = self
        }
    }
    
    
    // MARK: - Touch Bar
    
    @available(OSX 10.12.2, *)
    func showImageInTouchBar(_ url: URL) {
        //print(url)
        
        if let touchbarImage = NSImage(contentsOf:url) {
            touchBarImageView.image = touchbarImage
            
            if touchbarImage.size.width == TouchBarSizes.fullWidth || touchbarImage.size.width == TouchBarSizes.fullWidth/2 {
                imageViewSpaceConstraintLeft.constant = -TouchBarSizes.systemButtonWidth-TouchBarSizes.regionSpace
            }
            
            emptyLabel.isHidden = true
        }
    }
    

}
