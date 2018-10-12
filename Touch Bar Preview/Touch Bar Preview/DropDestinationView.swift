//
//  DropDestinationView.swift
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

protocol DropDestinationViewDelegate {
    func processImageURLs(_ urls: [URL])
}

// MARK: -

class DropDestinationView: NSView {
    
    @IBOutlet weak var dropIconView: NSImageView!
    
    enum Appearance {
        static let receivingDropLineWidth: CGFloat = 10.0
        static let dropImageAlphaNormal: CGFloat = 0.2
        static let dropImageAlphaHover: CGFloat = 0.5
    }
    
    // defining the delegate
    var delegate: DropDestinationViewDelegate?
    
    // MARK: -
    
    override func awakeFromNib() {
        setup()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        dropIconView.wantsLayer = true
        dropIconView.alphaValue = Appearance.dropImageAlphaNormal
        
        if isReceivingDrag {
            NSColor.selectedControlColor.set()
            
            let path = NSBezierPath(rect:bounds)
            path.lineWidth = Appearance.receivingDropLineWidth;
            path.stroke()
            
            dropIconView.alphaValue = Appearance.dropImageAlphaHover
            dropIconView.unregisterDraggedTypes()
        }
    }
    
    
    // MARK: - Drag File Type
    
    
    // define the supported types -> URL
    //var acceptableTypes: Set<String> { return [NSPasteboard.PasteboardType(kUTTypeURL as String).rawValue] }
    
    func setup() {
        self.registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeURL as String)])
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideDragAndDropIcon), name: NSNotification.Name("hideDragAndDropIcon"), object: nil)
    }
    
    
    // define URL types -> images
    let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes:NSImage.imageTypes]
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        
        var canAccept = false
        
        // referenece to the dragging pasteboard
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        // ask pasteboard if URLs reference to images
        if pasteBoard.canReadObject(forClasses: [NSURL.self], options: filteringOptions) {
            canAccept = true
        }
        
        return canAccept
    }
    
    
    // MARK: - Handling the Drag n Drop
    
    // property to trigger redraw on receiving drag
    var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }
    
    
    // decide if drag is allowed
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllowDrag(sender)
        isReceivingDrag = allow
        
        return allow ? .copy : NSDragOperation()
    }
    
    
    // handling a drag exit
    override func draggingExited(_ sender: NSDraggingInfo?) {
        isReceivingDrag = false
    }
    
    
    // triggering the drop on releasing the mouse
    // last chance to reject or accept the drag
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let allow = shouldAllowDrag(sender)
        
        return allow
    }
    
    
    // perform the actual operation with the image
    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
        // the drag is done, so view can be redrawn
        isReceivingDrag = false
        
        // hide the drop icon as we don't need this anymore
        hideDragAndDropIcon()
        
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        // hand off any image URLs to the delegate for processing
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options:filteringOptions) as? [URL], urls.count > 0 {
            delegate?.processImageURLs(urls)
            return true
        }
        return false
        
    }
    
    @objc func hideDragAndDropIcon() {
        dropIconView.isHidden = true
    }
    
}
