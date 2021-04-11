//
//  HelperFunctions.swift
//  Flight Docs Inventory Manager
//
//  Created by Dan Kardell on 4/10/21.
//

import Foundation

struct HelperFunctions {
// ===================================================
//
// ===================================================
static func applicationVersion() -> String {
    
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}


// ===================================================
//
// ===================================================
static func applicationBuild() -> String {
    
    return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
}


// ===================================================
//
// ===================================================
static func versionBuild() -> String {
    
    let version = self.applicationVersion()
    let build = self.applicationBuild()
    
    return "v\(version)(\(build))"
}
}

