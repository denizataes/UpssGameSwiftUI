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
                    .foregroundColor(Color(red: 26/255, green: 166/255, blue: 105/255))
                
            }
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
extension ContentView{
    func getScreenBounds() -> CGRect{
        return UIScreen.main.bounds
    }
}
