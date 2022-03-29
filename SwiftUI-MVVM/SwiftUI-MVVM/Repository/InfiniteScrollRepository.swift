//
//  InfiniteScrollRepository.swift
//  SwiftUI-MVVM
//
//  Created by Luann Luna on 28/03/22.
//

import RxSwift

protocol InfiniteScrollRepositoryProtocol {
    func getDataArray() -> BehaviorSubject<[DataInfo]>
    func fetchListItems(currentListSize: Int)
}

class InfiniteScrollRepository: InfiniteScrollRepositoryProtocol {
    
    private let listObservable = BehaviorSubject<[DataInfo]>(value: [])
    
    func getDataArray() -> BehaviorSubject<[DataInfo]> {
        return listObservable
    }
    
    func fetchListItems(currentListSize: Int) {
        var dummyList: [DataInfo] = []
        
        let limit = 20
        
        let page = currentListSize / limit + 1
        
        for index in 1...limit {
            dummyList.append(DataInfo(value: "Page: \(page) -> Item: \(index)", id: index + currentListSize))
        }
        
        listObservable.onNext(dummyList)
    }
}
