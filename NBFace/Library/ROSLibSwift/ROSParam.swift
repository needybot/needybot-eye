//
//  ROSParam.swift
//  NBFace
//
//  Created by David Glivar on 2/26/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

class ROSParam: NSObject {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func get(callback: ROSHandler) {
        let service = ROSService(service: "/rosapi/get_param", type: "rosapi/GetParam", args: ["name": self.name])
        service.callService(ROSHandler() { data in
            callback.handle(data)
        })
    }
}