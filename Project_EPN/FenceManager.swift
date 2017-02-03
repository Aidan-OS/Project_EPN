//
//  FenceManager.swift
//  Project_EPN
//
//  Created by Aidan Smith on 2016-09-19.
//  Copyright © 2016 ShamothSoft. All rights reserved.
//

import UIKit
 

class FenceManager: Any {
    
    var fenceList: Array <Fence>

    init () {
        fenceList = Array <Fence>()
        load()
    }
    
    public func fence (at index: Int) -> Fence {
        return fenceList [index]
    }
    
    public func append (_ fence: Fence) {
        fenceList.append(fence)
        save()
    }
    
    public func remove (at index: Int) {
        guard index < fenceList.count else {
            return
        }
        fenceList.remove(at: index)
        save()
    }
    
    public func replace (at index: Int, fence: Fence) {
        guard index < fenceList.count else {
            return
        }
        fenceList.replaceSubrange(index...index, with: [fence])
        save()
    }
    
    private func save () {
        // TODO: save list to UserDefaults
    }
    
    private func load () {
        // TODO: load list from UserDefaults
    }
}
