//
//  AppDelegate.swift
//  IdentifierApp
//
//  Created by Marco Smolla on 29.04.18.
//  Copyright © 2018 Marco Smolla. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @objc func printQuote(_ sender: Any?) {
        //let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        //let quoteAuthor = "Mark Twain"
        
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< 5 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        let number = arc4random_uniform(100) // [10, 99]
        let idString = randomString.prefix(2) + String(number) + randomString.suffix(3)
        
        copyToClipBoard(textToCopy: String(idString))
        print("\(idString)") // \(quoteText) — \(quoteAuthor)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("beer-solid"))
            button.action = #selector(printQuote(_:))
        }
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Get Identifier", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "c"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    func copyToClipBoard(textToCopy: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(textToCopy, forType: .string)
        
    }
    
}

