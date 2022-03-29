//
//  InfiniteScrollView.swift
//  SwiftUI-MVVM
//
//  Created by Luann Luna on 28/03/22.
//

import SwiftUI
import RxSwift

protocol ViewUpdateProtocol {
    func appendData(list: [DataInfo]?)
}

struct InfiniteScrollView: View {
    
    @ObservedObject var myList = ObservableArray<DataInfo>(array: [
        DataInfo(value: "Infinite Scroll", id: 0)
    ])
    
    let viewModel = InfiniteScrollViewModel()
    
    init() {
        self.viewModel.viewUpdate = self
    }
    
    var body: some View {
        List(myList.array.enumerated().map {$0}, id: \.1.self.id) { (index, listItem) in
            Text(listItem.value).onAppear {
                let count = myList.array.count
                
                if index == count-1 {
                    self.viewModel.getNewItems(currentListSize: count)
                }
            }
        }
    }
}

extension InfiniteScrollView: ViewUpdateProtocol {
    func appendData(list: [DataInfo]?) {
        myList.array.append(contentsOf: list!)
    }
}

struct InfiniteScrollView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteScrollView()
    }
}
