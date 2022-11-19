import SwiftUI

struct QuestionView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var categoryName: String
    var categoryImage: String
    var isPriced: Bool

    @State var cards: [Question] = []
    @State var showAddPopUp: Bool = false
    
    var body: some View {
        ZStack{
//            if !isPriced{
                BoomerangCard(categoryName: categoryName, cards: $cards)
                
                    .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.55)
                    .padding(.horizontal, 15)
                    .offset(y:50)
                    
                
                AddQuestionView(showAddPopUp: $showAddPopUp,categoryName: categoryName)
//            }
//            else
//            {
//                Text("Yok Öyle İş Uyanık")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .bold()
//            }
            
            
        }

        .background(
            Image(categoryName == "Erkekler" ? "boys" :
                    (categoryName == "Kızlar" ? "girls" :
                        (categoryName == "Edepsizler" ? "dirty" :
                            (categoryName == "Arkadaşlar" ? "friends" : "lovers")))
                 )
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            HStack{
                Image(systemName: "arrow.left")
                Text("Kategoriler")
            }
            .foregroundColor(.white)
            .fontWeight(.bold)
            .opacity(showAddPopUp ? 0 : 1)
            .transition(.slide)
        })
        .navigationBarItems(trailing: Button(action : {
            showAddPopUp.toggle()
        }){
            HStack{
                Image(systemName: showAddPopUp ? "xmark" : "plus")
                Text(showAddPopUp ? "Kapat" : "Soru Ekle")
                    
            }
            .transition(.opacity)
            .foregroundColor(.white)
            .fontWeight(.bold)
        })
        .edgesIgnoringSafeArea(.top)
                .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                
                    if(value.startLocation.x < 20 && value.translation.width > 100) {
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }))
    }
}


struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(categoryName: "girls", categoryImage: "girlsBackground",isPriced: false)
    }
}
struct BoomerangCard: View {
    var isRotationEnabled: Bool = true
    var isBlurEnabled: Bool = false
    var categoryName:String
    @Binding var cards: [Question]
    @StateObject var questionController = QuestionController()
    
    //MARK : Gesture Properties
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    @State var colorIndex :Int = 0
    @State var cardCount: Int = 0
    @State var incrementValue: Int = 12
    @State var isEnd : Bool = false
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            if questionController.loading{
                ZStack{
                    ActivityIndicator()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
            }else{
                ZStack{
                    ForEach(cards.reversed()) { card in
                        CardView(card: card, size: size)
                        // MARK: Moving Only Current Active Card
                            .offset(y: currentIndex == indexOf(card: card) ? offset : 0)
                        
                    }
                    
                }
                .onAppear{
                    setupCards()
                }
                .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
                .frame(width: size.width, height: size.height)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 2)
                        .onChanged(onChanged(value:))
                        .onEnded(onEnded(value:))
                )
            }
          
        }
        .onAppear{
            questionController.getQuestion(categoryName: categoryName)
        }
    }
    
    func setupCards(){
        
        var imageCount = 1
        
        
        
        if cardCount == questionController.questionList.count {
            isEnd.toggle()
            cardCount = 0
            incrementValue = 10
            for i in cardCount...cardCount + incrementValue {

                if imageCount > 6 {
                    imageCount = 1
                }

                cards.append(.init(question: questionController.questionList[i], image: imageCount == 1 ? "background" : "background\(imageCount)"))
                imageCount += 1
            }
            
        }
        else if cardCount + incrementValue < questionController.questionList.endIndex{
            
            for i in cardCount...cardCount + incrementValue {
                
                if imageCount > 6 {
                    imageCount = 1
                }
         
                cards.append(.init(question: questionController.questionList[i], image: imageCount == 1 ? "background" : "background\(imageCount)"))
                imageCount += 1
            }
        }
        else
        {
            incrementValue = questionController.questionList.endIndex - cardCount
            for i in cardCount...cardCount + incrementValue - 1 {
                
                if imageCount > 6 {
                    imageCount = 1
                }
                print(questionController.questionList.endIndex)
                cards.append(.init(question: questionController.questionList[i], image: imageCount == 1 ? "background" : "background\(imageCount)"))
                imageCount += 1
            }
            
        }
        
        cards.shuffle()
        
        if var first = cards.first{
            first.id = UUID().uuidString
            cards.append(first)
        }
    }
    
    // MARK: Gesture Calls
    func onChanged(value: DragGesture.Value){
        //        let impactMed = UIImpactFeedbackGenerator(style: .soft)
        //         impactMed.impactOccurred()
        offset = currentIndex == (cards.count - 1) ? 0 : value.translation.height
        
    }
    func onEnded(value: DragGesture.Value){
        var translation = value.translation.height
        // since we only need negative
        
        translation = (translation < 0 ? -translation : 0)
        translation = (currentIndex == (cards.count - 1) ? 0 : translation)
        // MARK: Since our card height = 220
        if translation > 85{
          
            withAnimation(.spring(response: 0.5,dampingFraction: 0.6,blendDuration: 0.6)){
                // applying rotation and extra offset
                
                //applying rotation and extra offset
                cards[currentIndex].isRotated = true
                cards[currentIndex].extraOffset = -550
                // give slightly bigger than card height
                cards[currentIndex].scale = 0.7
            }
            
            // after a little delay resetting gesture offset and extra offset
            //pushing card into back using zindex
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                withAnimation(.spring(response: 0.5,dampingFraction: 0.6,blendDuration: 0.6)){
                    cards[currentIndex].zIndex = -100
                    for index in cards.indices{
                        cards[index].extraOffset = 0
                    }
                    // MARK: Updating current index
                    if currentIndex != (cards.count - 1){
                        currentIndex += 1
                    }
                    offset = .zero
                }
            }
            
            //after animation completed resetting rotation and scaling and setting propoer zindex value
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                for index in cards.indices{
                    if index == currentIndex{
                        // MARK: Placing the card at right Index
                        // NOTE: Since the current index is updated +1 previously
                        // so the current index will be -1 now
                        if cards.indices.contains(currentIndex - 1) {
                            cards[currentIndex - 1].zIndex = ZIndex(card: cards[currentIndex - 1])
                        }
                    }else{
                        cards[index].isRotated = false
                        withAnimation(.linear){
                            cards[index].scale = 1
                        }
                    }
                }
                
                if currentIndex == (cards.count - 1){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                        //currentIndex = 0
                        for index in cards.indices{
                            // resetting zindex
                            cards[index].zIndex = 0
                        }
                        currentIndex = 0
                    }
                }
                
            }
            
            if currentIndex >= incrementValue - 1 {
                cards.removeAll()
                currentIndex = 0
                setupCards()
            }
            
            cardCount += 1
            
        }else{
            offset = .zero
        }
        let impactMed = UIImpactFeedbackGenerator(style: .soft)
        impactMed.impactOccurred()
    }
    
    
    func ZIndex(card: Question) -> Double{
        let index = indexOf(card: card)
        let totalCount = cards.count
        
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    @ViewBuilder
    func CardView(card: Question, size: CGSize) ->some View{
        let index = indexOf(card: card)
        let questionController = QuestionController()
        ZStack{
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getScreenBounds().width/1.1, height: getScreenBounds().height/1.55)
            
            Image(systemName: "minus.circle")
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .onTapGesture {
                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                    
                    questionController.deleteData(question: card.question)
                }

                
        
            HStack(spacing: 15){
                //                Text("")
                //                    .padding()
                //                Spacer()
                Text(card.question)
                    .foregroundColor(card.image == "background2" ? Color(red: 255/255, green: 168/255, blue: 0) :
                                        (card.image == "background3" ? Color(red: 0, green: 115/255, blue: 255/255):
                                            (card.image == "background4" ? Color(red: 255/255, green: 108/255, blue: 95/255):
                                                (card.image == "background5" ? Color(red: 205/255, green: 80/255, blue: 255/255) :
                                                    (card.image == "background" ? Color(red: 255/255, green: 109/255, blue: 195/255) : Color(red: 84/255, green: 158/255, blue: 16/255))))))
                
                    .fontWeight(.bold)
                    .font(.custom(FontManager.Pie.font, size: card.question.count > 70 ? 25 : 35))

                    //.font(.custom(FontManager.Pie.font, size: 35))
                    .frame(alignment: .trailing)
                    .padding(.horizontal, 35)
                    .multilineTextAlignment(.center)
            }
            
            
            
        }
        .blur(radius: card.isRotated && isBlurEnabled ? 6.5 : 0)
        .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))
        .scaleEffect(card.scale, anchor: card.isRotated ? .center : .top)
        .rotation3DEffect(.init(degrees: isRotationEnabled && card.isRotated ? 360 : 0),axis:(x: 0 , y: 0, z: 1))
        .offset(y: -offsetFor(index: index))
        .offset(y: card.extraOffset)
        .scaleEffect(scaleFor(index: index), anchor: .top)
        .zIndex(card.zIndex)
    }
    
    // MARK: Scale and Offset Values For Each Card
    func scaleFor(index value: Int) -> Double{
        let index = Double(value - currentIndex)
        // MARK: showing 3 cards now
        if index >= 0{
            if index > 6{
                return 0.8
            }
            // for each card 0.06 scale will be reduced
            return 1 - (index / 15)
        }else{
            if -index > 6{
                return 0.8
            }
            return 1 + (index / 15)
        }
    }
    
    func offsetFor(index value: Int) ->Double{
        let index = Double(value - currentIndex)
        
        if index >= 0{
            if index > 6{
                return 30
            }
            return (index * 10)
        }else{
            if -index > 6{
                return 30
            }
            return (-index * 10)
        }
        
        
    }
    
    func indexOf(card: Question) -> Int{
        if let index = cards.firstIndex(where: { CCard in
            CCard.id == card.id
        }){
            return index
        }
        return 0
    }
    func getScreenBounds() -> CGRect{
        return UIScreen.main.bounds
    }
    
}

