import SwiftUI

struct StartView: View {
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @ObservedObject var monitor = NetworkController()
    @State var showHomeView: Bool = false
    
    
    var body: some View {
        ZStack{
            
            if showHomeView{
                if monitor.isConnected{
                    ContentView(showHomeView: $showHomeView)
                }
                else{
                    NetworkView()
                }
            }
            else{
                
                ZStack{
                    Color(.systemBackground)
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    
                    WalkThroughScreens()
                    
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .trailing))
                .navigationBarHidden(true)
            }
        }
    }
    
    
    
    //MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View{
        let isLast = currentIndex == intros.count - 1
        GeometryReader{
            let size = $0.size
            
            ZStack{
                //MARK: Walk Through Screens
                ForEach(intros.indices, id: \.self){
                    index in
                    ScreenView(size: size, index: index)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y:-50)
            
            //MARK: Next Button
            
            .overlay(alignment: .bottom)
            {
                
                ZStack{
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    
                    HStack{
                        Text("Başla🔥")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 25, weight: .regular, design: .default))
                        
                        
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1: 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 2.2 : 55 ,height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background{
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(Color(red: 26/255, green: 166/255, blue: 105/255))
                }
                .onTapGesture {
                    if(isLast){
                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                        impactMed.impactOccurred()
                        showHomeView = true
                    }
                    else{
                        let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
                        currentIndex += 1
                    }
                }
                .offset(y: isLast ? -10: -10)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .offset(y:showWalkThroughScreens ? 0 : size.height)
        }
        
        
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) ->some View{
        let intro = intros[index]
        
        VStack{
            
            Image(intro.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width / 1,height: UIScreen.main.bounds.height / 1.8, alignment: .top)
                .cornerRadius(20)
                .padding(.top,10)
                .padding(.vertical,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.5), value: currentIndex)
            
            VStack(spacing: 10){
                
                Text(intro.title)
                    .offset(x: -size.width * CGFloat(currentIndex - index))
                    .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                    .fontWeight(.bold)
                    .font(.system(size: UIScreen.main.bounds.height < 1335 ? 24: 35, weight: .regular, design: .default))
                
                
                Text(intro.description)
                    .multilineTextAlignment(.center)
                   // .padding(.horizontal,30)
                    .offset(x: -size.width * CGFloat(currentIndex - index))
                    .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1), value: currentIndex)
                    .font(.system(size: UIScreen.main.bounds.height < 1335 ? 18 : 23, weight: .thin, design: .default))
                    .italic()
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
    //MARK: Navbar
    @ViewBuilder
    func NavBar() -> some View{
        let isLast = currentIndex == intros.count
        HStack{
            Button{
                if currentIndex > 0{
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                    currentIndex -= 1
                    
                }
                else{
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                    showWalkThroughScreens.toggle()
                }
                
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 26/255, green: 166/255, blue: 105/255))
            }
            Spacer()
            
            Button("Oyalama Geç 😏"){
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                impactMed.impactOccurred()
                showHomeView = true
            }
            .foregroundColor(Color(red: 26/255, green: 166/255, blue: 105/255))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
        
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        
        GeometryReader{
            let size =  $0.size
            
            VStack(spacing: 0)
            {
                VStack{
                    Image("intro")
                        .resizable()
//                         .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/2)
                        .aspectRatio(contentMode: .fill)
                  
                       
                }
                
                
                

                
                
                VStack(spacing: UIScreen.main.bounds.height < 1335 ? 12 : 20){
                    
                    Text("Parti Zamanı 🎉")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,55)
                        .fontWeight(.bold)
                        .font(.system(size: 35, weight: .regular, design: .default))
                    
                    Text("İçkileri doldur, geçmişi unut ve sıkı tutun 🥂 ")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Text("Nasıl Oynanır?")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .foregroundColor(.white)
                        .background{
                            Capsule()
                                .fill(Color(red: 26/255, green: 166/255, blue: 105/255))
                        }
                        .shadow(radius: 5)
                        .onTapGesture {
                            let impactMed = UIImpactFeedbackGenerator(style: .light)
                            impactMed.impactOccurred()
                            showWalkThroughScreens.toggle()
                        }
                }
                .padding(.vertical,80)
                
            }
            .offset(y: showWalkThroughScreens  ? -size.height : 0)
            
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
