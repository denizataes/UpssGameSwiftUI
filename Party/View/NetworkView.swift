//
//  LoadingView.swift
//  Party
//
//  Created by Deniz Ata Eş on 9.11.2022.
//

import SwiftUI

struct NetworkView: View {
  
    var body: some View {
        ZStack{
    
            Color(.systemBackground)
                    .ignoresSafeArea()
                VStack{
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .foregroundColor(Color("FontColor"))
                        .scaledToFit()
                        .frame(width:200, height: 200)
                        .padding(.vertical, 10)
                        
                    
                    Text("İnternet yok ⚠️ Ya da kafan iyi internetini açmayı unuttun ? ")
                        .foregroundColor(Color(.systemBackground))
                        .padding()
                        .background{
                            Capsule()
                                .fill(Color("FontColor"))
                        }
                        .font(.callout)
                }
            }
        .navigationBarHidden(true)
        
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
