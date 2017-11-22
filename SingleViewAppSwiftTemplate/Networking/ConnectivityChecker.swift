//
//  ConnectivityChecker.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import SystemConfiguration


/*
 [REVIEW] I'm not sure you need to do this anymore. URLSession has a connectivity checker built-in now.
 https://developer.apple.com/videos/play/wwdc2017/709/
*/
struct InternetChecker {
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
}
