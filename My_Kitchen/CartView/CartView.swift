//
//  CartView.swift
//  My_Kitchen
//
//  Created by Arjunan on 30/11/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: HomeViewVM
    var body: some View {
        ZStack {
            appGradientView
                .edgesIgnoringSafeArea(.all)
            VStack {
                headerView
                listCardView()
            }
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        VStack(alignment: .center) {
            Text("Favourite Foods")
                .font(.system(size: 26, weight: .bold, design: .default))
                .foregroundColor(Color.white)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func listCardView() -> some View {
        List(0..<viewModel.cartData.count, id: \.self) { index in
            let model = viewModel.cartData[index]
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.black.opacity(0.7))
                    .frame(width: 80, height: 80)
                VStack(alignment: .leading, spacing: 10) {
                    Text(model.name?.capitalized ?? "")
                    Text(model.price ?? "")
                }
                .font(.system(size: 16, weight: .regular, design: .default))
                .foregroundColor(Color.black.opacity(0.7))
                Button(action: {
                    for kitchenIndex in viewModel.kitchenData.indices {
                        if let itemIndex = viewModel.kitchenData[kitchenIndex].data?.firstIndex(where: { $0.id == model.kitchenId }) {
                            let model = viewModel.cartData[index]
                            viewModel.deleteData(data: model)
                            viewModel.kitchenData[kitchenIndex].data?[itemIndex].isSelect = false
                        }
                    }
                }, label: {
                    Image(systemName: "trash.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        .refreshable {
            
        }
    }
}


#Preview {
    CartView()
}
