//
//  AddQuestionView.swift
//  Party
//
//  Created by Deniz Ata Eş on 13.11.2022.
//

import SwiftUI

struct AddQuestionView: View {
    @Binding var showAddPopUp: Bool
    @State  var question: String = ""
    var categoryName: String
    @ObservedObject var qc = QuestionController()
    @State var showAlert: Bool = false

    var body: some View {
        if showAddPopUp{
            ZStack(alignment: .center){
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showAddPopUp = false
                    }
                    
            
                VStack{
                    Text("\(categoryName) Sorusu Oluştur...")
                        .padding()
                        .font(.system(size: 19, weight: .bold, design: .default))
                    
                    
                    Spacer()
                    TextEditor(text: $question)
                        .foregroundColor(.black)
                        .frame(height: 150)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.2), lineWidth: 4)
                        )
                        .padding()
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14, weight: .regular, design: .default))
                    Spacer()
                    Button{
                        question = ""
                        showAddPopUp.toggle()
                    }label: {
                        
                        Text("Ekle")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 7)
                            .foregroundColor(.white)
                            .background{
                                Capsule()
                                    .fill(Color(.systemBlue))
                            }
                            .shadow(radius: 5)
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .light)
                                impactMed.impactOccurred()
                                qc.addData(categoryName: categoryName, question: question)
                                showAlert.toggle()
                                
                            }
                        
                    }
                    .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Bilgi"),
                                message: Text("Başarıyla Kaydedildi Baba ✅")
                            )
                        }
                    
                    Spacer()
                    
                }
                .frame(height: 300)
                .frame(width: 350)
                .background(Color.white)
                .cornerRadius(15)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            
        }
  
    }

}

