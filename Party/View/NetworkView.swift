//
//  LoadingView.swift
//  Party
//
//  Created by Deniz Ata Eş on 9.11.2022.
//

import SwiftUI

struct NetworkView: View {
    @ObservedObject var monitor = NetworkController()
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            
            VStack{
                Image(systemName: monitor.isConnected ? "wifi" : "wifi.slash")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width:200, height: 200)
                    .padding(.vertical, 10)
                
                Text(monitor.isConnected ? "İnternet Bağlı" : "İnternet yok ⚠️ Ya da kafan iyi internetini açmayı unuttun ? ")
                    .foregroundColor(.white)
                    .padding()
                    .background{
                        Capsule()
                            .fill(Color(monitor.isConnected ? .blue : .red))
                    }
            }
        }
      
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
