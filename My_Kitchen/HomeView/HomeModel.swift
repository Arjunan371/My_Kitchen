//
//  HomeModel.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import Foundation

struct HomeModel {
    var id: String?
    var foodType: String?
    var data: [HomeModel.HomeModelData]?
    
    struct HomeModelData {
        var id: String?
        var image: String?
        var name: String?
        var price: String?
        var description: String?
        var isSelect = false
        var isAddToCart = false
    }
}
