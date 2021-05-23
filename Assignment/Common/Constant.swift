//
//  Constant.swift
//  SyncracyTest
//
//  Created by Anil on 04/04/21.
//

import Foundation

//http://iostest.thriwe.com/web/user/user.php?offset=0&limit=5


struct Constant {

    struct APPURL {
        static private let baseUrl = "http://iostest.thriwe.com/"
        
        private struct MainRoute {
            static let channellist = "web/user"
        }
        private static let BaseUrl = baseUrl + MainRoute.channellist
        
        static var userList : String{
            return BaseUrl + "/user.php?"
        }
    }
    
}
