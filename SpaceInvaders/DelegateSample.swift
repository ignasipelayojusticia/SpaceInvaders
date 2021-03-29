//
//  DelegateSample.swift
//  SpaceInvaders
//
//  Created by Guillermo Fernandez on 29/03/2021.
//

import Foundation

protocol ENTIDelegateProtocol {
    func initClass()
    func isClassOn() -> Bool
    func finishClass()
}


class ENTI {
    let subjectName: String!
    var delegate: ENTIDelegateProtocol?
    
    init(_ name: String, delegate: ENTIDelegateProtocol? = nil) {
        self.subjectName = name
        self.delegate = delegate
        
        self.delegate?.initClass()
    }
    
    func checkClass() {
        self.delegate?.isClassOn() == true ? print("Class is on") : print("Class is off")
    }
    
    deinit {
        self.delegate?.finishClass()
    }
    
}

class ENTIClassRoom: ENTIDelegateProtocol {
    func initClass() {
        print("Class started")
    }
    
    func isClassOn() -> Bool {
        return true
    }
    
    func finishClass() {
        print("Class finished")
    }
    
    let classRoom: ENTI
    
    init() {
        self.classRoom = ENTI("Programacio de VideoJocs Mobil")
        self.classRoom.delegate = self
    }
    
    func checkClass() {
        classRoom.checkClass()
    }
}
