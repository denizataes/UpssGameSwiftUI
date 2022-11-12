import SwiftUI
import Foundation

struct ContentView: View {
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    @Binding var showHomeView: Bool
    @Namespace var namespace
    @StateObject var categoryController = CategoryController()
    

    
    var body: some View {

        
        VStack{
            Spacer()
            if categoryController.categoryList.count > 0
            {
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack{
                        
                        ForEach(categoryController.categoryList){
                            category in
                            
                            NavigationLink(
                                
                                destination: QuestionView(categoryName: category.name, categoryImage: category.image)
                            )
                            {
                                Image(category.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 320, height: 550)
                                    .cornerRadius(20)
                                    .padding(7)
                                    .shadow(radius: 3)
                                
                            }
                        }
                        
                    }
                    .padding()
                    Spacer()
                }
            }
            else
            {
                ActivityIndicator()
                    .frame(width: 100,height: 100)
                    .foregroundColor(.pink)
                
            }
            Spacer()
            HStack{
                Spacer()
                ZStack{
                    Image("")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 15)
                        .onTapGesture {
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            showHomeView.toggle()
                        }
                    Text("🤔")
                        .font(.callout)
                }
            }
            .padding(.horizontal,25)
        }
        .onAppear{
            categoryController.getCategories()
        }
        .shadow(radius: 20)
        .navigationTitle("Kategoriler 🔥")
        .navigationBarTitleDisplayMode(.large)
        
    }

    
    struct ContentView_Previews: PreviewProvider {
        @State static var value = false
        
        static var previews: some View {
            ContentView(showHomeView: $value)
        }
    }
}
