//
//  HomeViewModel.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import Foundation
import CoreData
import SwiftUI

class HomeViewVM: ObservableObject {
    @Published var kitchenData: [HomeModel] = []
    @Published var favouriteData: [MyKitchenData] = []
    @Published var cartData: [MyKitchenData] = []
    let container = CoreDataManager.shared.container
    init() {
        DispatchQueue.main.async {
            self.dataCreation()
            self.initialFunction()
        }
    }
    
    func dataCreation() {
        var data1: [HomeModel.HomeModelData] = []
        var data2: [HomeModel.HomeModelData] = []
        var data3: [HomeModel.HomeModelData] = []
        let chinese1 = HomeModel.HomeModelData(id: "1", image: "kitchen", name: "Chinese", price: "200", description: "Such delicious, highly-rated food other country speciel")
        let chinese2 = HomeModel.HomeModelData(id: "2", image: "kitchen", name: "Chinese", price: "200", description: "Such delicious, highly-rated food other country speciel")
        let chinese3 = HomeModel.HomeModelData(id: "3", image: "kitchen", name: "Chinese", price: "200", description: "Such delicious, highly-rated food other country speciel")
        let rice1 = HomeModel.HomeModelData(id: "4", image: "rice", name: "Chicken rice", price: "150", description: "Such delicious, highly-rated food fast food")
        let rice2 = HomeModel.HomeModelData(id: "5", image: "rice", name: "Chicken rice", price: "150", description: "Such delicious, highly-rated food fast food")
        let rice3 = HomeModel.HomeModelData(id: "6", image: "rice", name: "Chicken rice", price: "150", description: "Such delicious, highly-rated food fast food")
        let seaFood1 = HomeModel.HomeModelData(id: "7", image: "seaFood", name: "Fish", price: "180", description: "Such delicious, highly-rated sea food")
        let seaFood2 = HomeModel.HomeModelData(id: "8", image: "seaFood", name: "Fish", price: "180", description: "Such delicious, highly-rated sea food")
        let seaFood3 = HomeModel.HomeModelData(id: "9", image: "seaFood", name: "Fish", price: "180", description: "Such delicious, highly-rated sea food")
        data1.append(chinese1)
        data1.append(chinese2)
        data1.append(chinese3)
        data2.append(rice1)
        data2.append(rice2)
        data2.append(rice3)
        data3.append(seaFood1)
        data3.append(seaFood2)
        data3.append(seaFood3)
        let model1 = HomeModel(id: "111", foodType: "Other Country Foods",data: data1)
        let model2 = HomeModel(id: "222", foodType: "Fast Food",data: data2)
        let model3 = HomeModel(id: "333", foodType: "Sea Food",data: data3)
        kitchenData.append(model1)
        kitchenData.append(model2)
        kitchenData.append(model3)
    }
    
    func save(model: HomeModel.HomeModelData?, typeIndex: Int, index: Int, context: NSManagedObjectContext) {
        let data = MyKitchenData(context: context)
        if let model = model {
            data.kitchenId = model.id
            data.name = model.name
            data.image = model.image
            if kitchenData[typeIndex].data?[index].isSelect == true  {
                data.isFavourite = true
                data.price = model.price
            }
            if kitchenData[typeIndex].data?[index].isAddToCart == true {
                if let lastIndex = cartData.lastIndex(where: {$0.kitchenId == model.id}) {
                    let modelPrice = Int(model.price ?? "") ?? 0
                    let dataPrice = Int(data.price ?? "") ?? 0
                    let price = modelPrice + dataPrice
                    data.price = String(price)
                } else {
                    data.isCart = true
                    data.price = model.price
                    
                }
            }
            saveData()
        }
    }
}

extension HomeViewVM {
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch {
            
        }
    }
    
    func initialFunction() {
        saveData()
        for dbIndex in 0..<favouriteData.count {
            for index in 0..<kitchenData.count {
                if let dataIndex = kitchenData[index].data?.firstIndex(where: {$0.id == favouriteData[dbIndex].kitchenId}) {
                    kitchenData[index].data?[dataIndex].isSelect = favouriteData[dbIndex].isFavourite
                }
            }
        }
    }
    
    func fetchData() {
        let request = NSFetchRequest<MyKitchenData>(entityName: "MyKitchenData")
        do {
            favouriteData = try container.viewContext.fetch(request).filter({$0.isFavourite == true})
                cartData = try container.viewContext.fetch(request).filter({$0.isCart == true})
            print("shoppingData",favouriteData)
        } catch let error {
            print("fetchin  failed \(error)")
        }
    }
    
    func deleteData(data: MyKitchenData) {
        container.viewContext.delete(data)
        saveData()
    }
}


