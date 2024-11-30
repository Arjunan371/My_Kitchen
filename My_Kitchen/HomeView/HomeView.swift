//
//  ContentView.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewVM
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [])
        var users: FetchedResults<MyKitchenData>
    var body: some View {
        GeometryReader { geo in
            ZStack {
                appGradientView
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    headerAndSearchBarView( geo.size)
                }
            }
            .onAppear {
          //      viewModel.initialFunction(data: users)
            }
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Hi, Shriram")
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundColor(AppColor.white)
                Text("Welcome to our kitchen")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(AppColor.white.opacity(0.97))
            }
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.white)
                Image(systemName: "person")
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.black)
                    .background(Color.clear)
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func headerAndSearchBarView(_ size: CGSize) -> some View {
        VStack(spacing: 20) {
            headerView
            listCardView(size)
        }
    }
    
    @ViewBuilder
    private func listCardView(_ size: CGSize) -> some View {
        List(0..<viewModel.kitchenData.count, id: \.self) { index in
            let model = viewModel.kitchenData[index]
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Text(model.foodType?.capitalized ?? "")
                    Text("(\(String(format: "%02d", model.data?.count ?? 0)))")
                }
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(Color.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                listContentView(size, model.data ?? [], index)
            }
            .padding(.bottom, 5)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        .refreshable {
            
        }
    }
    
    @ViewBuilder
    private func listContentView(_ size: CGSize,_ data: [HomeModel.HomeModelData], _ typeIndex: Int) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(0..<data.count, id: \.self) { index in
                    let model = data[index]
                    VStack(alignment: .leading, spacing: 8) {
                        favouriteView(typeIndex: typeIndex, index: index)
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.black.opacity(0.7))
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)
                        HStack {
                            Text(model.name?.capitalized ?? "")                                
                            Text("Rs. \(model.price ?? "")")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(Color.black.opacity(0.7))
                        Text(model.description ?? "")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(Color.black.opacity(0.7))
                        cartView(typeIndex: typeIndex, index: index)
                    }
                    .padding(14)
                    .frame(width: 230, height: 380)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func favouriteView(typeIndex: Int, index: Int) -> some View {
        Button(action: {
            let model = viewModel.kitchenData[typeIndex].data?[index]
            viewModel.kitchenData[typeIndex].data?[index].isSelect.toggle()
            if viewModel.kitchenData[typeIndex].data?[index].isSelect == true {
                viewModel.save(model: model, typeIndex: typeIndex, index: index, context: viewContext)
            }
        }, label: {
            Image(systemName: viewModel.kitchenData[typeIndex].data?[index].isSelect == true ? "star.fill" : "star")
        })
        .frame(maxWidth: .infinity, alignment: .topTrailing)
    }
    
    @ViewBuilder
    private func cartView(typeIndex: Int, index: Int) -> some View {
        Button(action: {
            let model = viewModel.kitchenData[typeIndex].data?[index]
            viewModel.kitchenData[typeIndex].data?[index].isAddToCart.toggle()
            if viewModel.kitchenData[typeIndex].data?[index].isAddToCart == true {
                viewModel.save(model: model, typeIndex: typeIndex, index: index, context: viewContext)
            }
        }, label: {
            ZStack {
                Capsule()
                    .foregroundColor(Color.yellow)
                Text("Add to cart")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(Color.black.opacity(0.7))
            }
            .frame(height: 45)
        })
        
    }
    
}

#Preview(body: {
    HomeView()
})
