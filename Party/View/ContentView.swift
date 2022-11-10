import SwiftUI
import Foundation

struct ContentView: View {
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    @Binding var showHomeView: Bool
    @Namespace var namespace
    @ObservedObject var categoryController = CategoryController()
    @State var isLoading: Bool = false
    var body: some View {
        
        
        VStack{
            
            HStack{
                Text("Kategoriler 🔥")
                    .foregroundColor(Color("FontColor"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal,20)
                    .padding(.vertical,20)
                    .frame(alignment: .leading)
                
                
                Spacer()
                VStack{
                    Image("memoji")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                        .padding()
                    
                }
                
            }
            
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
        .buttonStyle(.plain)
        .navigationTitle("Kategoriler 🔥")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarHidden(true)   
    }
    
    func loading(){
        isLoading = true;
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            
            isLoading = false;
        }
        
    }
    struct ContentView_Previews: PreviewProvider {
        @State static var value = false
        
        static var previews: some View {
            ContentView(showHomeView: $value)
        }
    }
}
