//
//  Observable.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

final class Observable<T> {
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
        
    init (_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind (_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
