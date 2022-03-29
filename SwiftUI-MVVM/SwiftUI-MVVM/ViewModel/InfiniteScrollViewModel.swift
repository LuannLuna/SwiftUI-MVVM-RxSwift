//
//  InfiniteScrollViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Luann Luna on 28/03/22.
//

import Foundation
import RxSwift

class InfiniteScrollViewModel {
    let infiniteScrollRepo: InfiniteScrollRepositoryProtocol
    var viewUpdate: ViewUpdateProtocol? = nil
    let disposebag = DisposeBag()
    
    init(infiniteScrollRepo: InfiniteScrollRepositoryProtocol = InfiniteScrollRepository()) {
        self.infiniteScrollRepo = infiniteScrollRepo
        
        self.infiniteScrollRepo.getDataArray().subscribe({ [weak self] newList in
            self?.updateListItems(newList: newList.element)
        }).disposed(by: disposebag)
    }
    
    func getNewItems(currentListSize: Int) {
        infiniteScrollRepo.fetchListItems(currentListSize: currentListSize)
    }
    
    func updateListItems(newList: [DataInfo]?) {
        if newList != nil && !newList!.isEmpty {
            self.viewUpdate?.appendData(list: newList)
        }
    }
}
