//
//  ObservableArray.swift
//  SwiftUI-MVVM
//
//  Created by Luann Luna on 28/03/22.
//

import Foundation
import Combine

class ObservableArray<T>: ObservableObject {
    
    var cancellables = [AnyCancellable]()
    @Published var array: [T] = []
    
    init(array: [T]) {
        self.array = array
    }
    
    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        if let arr = array as? [T] {
            arr.forEach {
                let c = $0.objectWillChange.sink { _ in
                    self.objectWillChange.send()
                }
                
                self.cancellables.append(c)
            }
        }
        
        return self as! ObservableArray<T>
    }
}
