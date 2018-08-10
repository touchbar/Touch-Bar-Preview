//
//  AppDelegate.swift
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

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // reopen the main window if you click on the dock icon
        if let window = sender.windows.first {
            if flag {
                window.orderFront(nil)
            } else {
                window.makeKeyAndOrderFront(nil)
            }
        }
        return true
    }

    // MARK: - Menu Links
    
    @IBAction func showMainWindow(_ sender: Any) {
        NSApplication.shared.windows.first?.makeKeyAndOrderFront(self)
    }
    
    @IBAction func checkForUpdates(_ sender: NSMenuItem) {
        let alert = showUpdateAlert()
        
        if alert == true {
            let urlString = NSURL(string: "https://github.com/touchbar/Touch-Bar-Preview/releases/latest")
            NSWorkspace.shared.open(urlString! as URL)
        }
    }
    
    func showUpdateAlert() -> Bool {
        let updateAlert: NSAlert = NSAlert()
        updateAlert.messageText = "Updating Touch Bar Preview"
        updateAlert.informativeText = "You've installed version \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String) (\(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)). Please check manually for newer versions."
        updateAlert.alertStyle = NSAlert.Style.warning
        updateAlert.addButton(withTitle: "Check Now")
        updateAlert.addButton(withTitle: "Later")
        return updateAlert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
    }
    
    @IBAction func openWebsite(_ sender: NSMenuItem) {
        var urlString = NSURL(string: "")
        
        switch sender.tag {
        case 0:
            urlString = NSURL(string: "https://touchbar.github.io")
        case 1:
            urlString = NSURL(string: "https://github.com/touchbar/Touch-Bar-Preview")
        case 2:
            urlString = NSURL(string: "https://github.com/touchbar/Touch-Bar-Preview/issues")
        case 10:
            urlString = NSURL(string: "https://github.com/alexkaessner/macOS-UI-Kit")
        default:
            return
        }
        
        NSWorkspace.shared.open(urlString! as URL)
    }
    
    @IBAction func openHelp(_ sender: NSMenuItem) {
        let urlString = NSURL(string: "https://github.com/touchbar/Touch-Bar-Preview/wiki")
        NSWorkspace.shared.open(urlString! as URL)
    }

}

