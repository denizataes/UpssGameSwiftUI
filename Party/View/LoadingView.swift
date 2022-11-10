//
//  LoadingView.swift
//  Party
//
//  Created by Deniz Ata Eş on 9.11.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color(.white)
                .ignoresSafeArea()
                .shadow(radius: 80)
            
            ProgressView("İçkileri Hazırla, Yükleniyor...")
            //deneme
            
                .foregroundColor(.black)
                .shadow(radius: 50)
                .scaleEffect(1.5, anchor: .center)
                .font(.caption)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
