//
//  ListInteractor.swift
//  AssignmentTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

protocol ListBusinessLogic {
    func List(request: ListModel.Process.Request, offset : Int, limit: Int)
}
class ListInteractor: ListBusinessLogic{
    var worker = ListWorker()
    var presenter : ListPresenter?
    func List(request: ListModel.Process.Request, offset : Int, limit: Int) {
        
        
        worker.hitMethodForGetList(offset: offset, limit: limit) { (obj) in
            self.presenter?.presentList(response: obj)
        } fail: { (message) in
            self.presenter?.presentList(response: ListModel.Process.Response(success: false))
        }


    }
}
