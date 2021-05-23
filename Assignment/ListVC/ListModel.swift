//
//  ListModel.swift
//  AssignmentTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

enum ListModel{
    enum Process {
        struct Request {
            var type : String?
        }
        
        struct Response {
            var success : Bool
            var msg : String?
            var list : ListResponseModel?
        }
        struct ViewModel {
            var success : Bool
            var msg : String?
            var list : ListResponseModel?
        }
    }
}

struct ListResponseModel : Codable{
    let status : Bool?
    let message : String?
    let data : data?
}

struct data : Codable {

    let users : [users]?

}

struct users : Codable{
    let userId : String?
    let name : String?
    let image : String?
    let items : [String]?
    let description : String?
}

