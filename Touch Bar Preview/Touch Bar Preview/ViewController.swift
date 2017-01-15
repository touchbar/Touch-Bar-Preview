//
//  ViewController.swift
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

class ViewController: NSViewController {
    
    @IBOutlet var dropDestinationView: DropDestinationView!
    @IBOutlet weak var imagePreviewView: NSImageView!
    
    @IBOutlet weak var bottomBarInfoLable: NSTextField!
    @IBOutlet weak var bottomBarAlertImageWidth: NSLayoutConstraint!

    public var windowDelegate: WindowController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dropDestinationView.delegate = self
        
        // "hide" alert icon in bottom bar
        bottomBarAlertImageWidth.constant = 0.0
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // Accessory view controller to hold the "Download UI Kit" button as part of the window's titlebar.
    var titlebarAccessoryViewController : NSTitlebarAccessoryViewController!
    
    override func viewWillAppear() {
        titlebarAccessoryViewController = storyboard?.instantiateController(withIdentifier: "titleBarAccessory") as! NSTitlebarAccessoryViewController!
        titlebarAccessoryViewController.layoutAttribute = .right
        self.view.window?.addTitlebarAccessoryViewController(self.titlebarAccessoryViewController)
    }

}

// MARK: - DropDestinationViewDelegate
extension ViewController: DropDestinationViewDelegate {
    
    func processImageURLs(_ urls: [URL]) {
        for (_,url) in urls.enumerated() {
            
            // pass URL to Window Controller
            windowDelegate?.showImageInTouchBar(url)
            
            // create the image from the content URL
            if let image = NSImage(contentsOf:url) {
                
                imagePreviewView.image = image
                
                // check if the image has the touch bar size (2170x60px)
                // and inform the user
                if image.size.width > TouchBarSizes.fullWidth || image.size.height > TouchBarSizes.fullHeight {
                    bottomBarInfoLable.stringValue = "Image is too big! Should be 2170x60px."
                    bottomBarInfoLable.toolTip = "The image is \(Int(image.size.width))x\(Int(image.size.height))px."
                    
                    // show alert icon in bottom bar
                    bottomBarAlertImageWidth.constant = 20.0
                    
                } else if image.size.width == TouchBarSizes.fullWidth && image.size.height == TouchBarSizes.fullHeight {
                    bottomBarInfoLable.stringValue = "✓ Image is correct!"
                    bottomBarInfoLable.toolTip = nil
                    
                } else {
                    bottomBarInfoLable.stringValue = "Image should be 2170x60px"
                    bottomBarInfoLable.toolTip = nil
                    
                    // "hide" alert icon in bottom bar
                    bottomBarAlertImageWidth.constant = 0.0
                    
                }
            }
        }
    }
    
}

