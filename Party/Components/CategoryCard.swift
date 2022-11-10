//
//  CategoryCard.swift
//  Party
//
//  Created by Deniz Ata Eş on 28.10.2022.
//

import SwiftUI

struct CategoryCard: View {
    var category: Category
    var body: some View {
        VStack(spacing: 0){
            Image(category.image)
                .resizable()
                .cornerRadius(20)
                .frame(width: 180)
                .scaledToFit()

            VStack(alignment: .leading){
                Text(category.name)
                    .bold()
                Text(category.description)
                    .font(.system(size: 13, weight: .regular, design: .default))
                    .foregroundColor(.white)
                Text("\(category.price) \(category.price != "" ? "TL" : "Ücretsiz")")
                    .font(.system(size: 10, weight: .bold, design: .default))
                    .foregroundColor(.green)



            }
            .padding()
            .frame(width: 180, alignment: .leading)
            .background(.ultraThinMaterial)
            .cornerRadius(20)

        }.frame(width: 180, height: 300)
            .shadow(radius: 4)

    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(category: Category(id: "1", name: "Deneme", description: "Deneme Yazısı", image: "boys", price: "Ücretsiz"))
    }
}
