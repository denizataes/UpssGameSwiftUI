import SwiftUI
import Foundation

struct ContentView: View {
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    @Binding var showHomeView: Bool
    @Namespace var namespace
    @StateObject var categoryController = CategoryController()
    @State var showHome : Bool = false
    
    
    
    var body: some View {
        
        VStack{
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
                                    .frame(width: getScreenBounds().width/1.2, height: getScreenBounds().height/1.55)
                                    .cornerRadius(20)
                                    .padding(7)
                                    .shadow(radius: 3)
                                
                            }
                        }
                        
                    }
                    .padding()
                    
                }
            }
            else
            {
                ActivityIndicator()
                    .frame(width: 80,height: 80)
                    .foregroundColor(.pink)
                
            }
        }
        .onAppear{
            categoryController.getCategories()
        }
        .shadow(radius: 20)
        .navigationTitle("Kategoriler 🔥")
        .navigationBarTitleDisplayMode(.large)
        
        
//        ZStack{
//
//            Image("")
//                .resizable()
//                .frame(width: getScreenBounds().height / 20, height: getScreenBounds().height / 24)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 3))
//                .shadow(radius: 15)
//                .onTapGesture {
//                    let impactMed = UIImpactFeedbackGenerator(style: .light)
//                    impactMed.impactOccurred()
//                    showHomeView.toggle()
//                }
//            Text("🤔")
//                .font(.system(size: getScreenBounds().height / 56, weight: .regular, design: .default))
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
//        .ignoresSafeArea(.all, edges: .bottom)
//        .padding(.vertical,getScreenBounds().height/150)
//        .padding(.horizontal,getScreenBounds().width/30)


        
            
            //getScreenBounds().height < 500 ? .trailing : .horizontal)
        
        
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        @State static var value = false
        
        static var previews: some View {
            ContentView(showHomeView: $value)
        }
    }
}
extension ContentView{
    func getScreenBounds() -> CGRect{
        return UIScreen.main.bounds
    }
}
