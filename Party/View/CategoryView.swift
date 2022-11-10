////
////  CategoryView.swift
////  Party
////
////  Created by Deniz Ata Eş on 7.11.2022.
////
//
//import SwiftUI
//
//struct CategoryView: View {
//
//    @ObservedObject var categoryController = CategoryController()
//
//    //    @State var categoryList = [
//    //        Category(id: 0 ,name: "Erkek Erkeğe", description: "Messi Mercedesle Mervelere giderkene 🛞⚽️🍆",image: "background2", price:"Ücretsiz",offset: 0),
//    //        Category(id: 1 ,name: "Arkadaşlar", description: "Ya da arkadaşın sandıkların 🤞🏻",image: "background3", price:"10",offset: 0),
//    //        Category(id: 2 ,name: "Sevgililer", description: "Dikkat son dakikalarınız olabilir 🥶💞", image: "background4", price:"5",offset: 0),
//    //        Category(id: 3 ,name: "Kız Kıza", description: "Bütün kızlar toplandık, toplandık, toplandık 💃🏼", image: "background5", price:"10",offset: 0),
//    //        Category(id: 4 ,name: "Karışık", description: "Sen bize naap biliyo musun ? 🥗",image: "background6", price:"5",offset: 0)
//    //    ]
//
//    @State var scrolled:Int = 0
//
//
//    var body: some View {
//
//        ScrollView(.vertical, showsIndicators: false){
//            VStack{
//                HStack{
//                    Text("Kategoriler 🔥")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .frame(alignment: .leading)
//
//
//                    Spacer()
//                    VStack(spacing: -20){
//                        Image("memoji")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 50,height: 50)
//                            .padding()
//
//                    }
//
//                }
//                .padding()
//
//                ZStack{
//                    ForEach(categoryController.categoryList.reversed()) { category in
//                        HStack{
//
//                            CardView(category: category, scrolled: $scrolled)
//
//                            Spacer(minLength: 0)
//
//                        }
//                        .contentShape(Rectangle())
//                        .offset(x: category.offset)
//                        .gesture(DragGesture().onChanged({ (value) in
//                            withAnimation{
//
//                                if value.translation.width < 0 && category.id != categoryController.categoryList.last!.id{
//
//                                    categoryController.categoryList[category.id].offset = value.translation.width
//                                    print(value.translation.width)
//                                }
//                                else{
//
//                                    if category.id > 0{
//                                        categoryController.categoryList[category.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
//                                    }
//                                }
//                                //  categoryList[category.id].offset = value.translation.width
//                            }
//                        }).onEnded( { (value) in
//                            withAnimation{
//
//                                if value.translation.width < 0{
//                                    if -value.translation.width > 60 && category.id != categoryController.categoryList.last!.id {
//
//                                        categoryController.categoryList[category.id].offset = -(calculateWidth() + 60)
//                                        scrolled += 1
//                                    }
//                                    else{
//                                        categoryController.categoryList[category.id].offset = 0
//                                    }
//                                }
//                                else{
//                                    if category.id > 0{
//                                        if value.translation.width > 60{
//                                            categoryController.categoryList[category.id - 1].offset = 0
//                                            scrolled -= 1
//                                        }
//                                        else{
//                                            categoryController.categoryList[category.id - 1].offset = -(calculateWidth() + 60)
//                                        }
//                                    }
//
//                                }
//                            }
//                        }))
//                    }
//                }
//                .frame(height: UIScreen.main.bounds.height / 1.8)
//                .padding(.horizontal, 25)
//                .padding(.top, 25)
//            }
//
//        }
//        .background(
//            Image("mainBackground")
//                .resizable()
//                .ignoresSafeArea()
//        )
//        .onAppear{
//            categoryController.getCategories()
//        }
//
//
//    }
//    func calculateWidth() -> CGFloat{
//        let screen = UIScreen.main.bounds.width - 50
//        let width = screen - (2 * 30)
//        return width
//    }
//
//
//}
//
//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
//
//
//
//
//struct CardFooter: View {
//    var category: Category
//    var body: some View {
//
//        VStack(alignment: .center , spacing: 18){
//
////
////                NavigationLink(destination: QuestionView(categoryName: category.name, categoryImage: category.image)) {
//
//                    Button(action : {}){
//                        Text("Oyna ⚡️")
//                            .font(.caption)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(.vertical, 15)
//                            .padding(.horizontal, 25)
//                            .background(.green)
//                            .clipShape(Capsule())
//                    }
//                //}
//
//        }
//        .frame(width: calculateWidth() - 40)
//        .padding(.leading, 20)
//        .padding(.bottom, 20)
//    }
//
//    func calculateWidth() -> CGFloat{
//        let screen = UIScreen.main.bounds.width - 50
//        let width = screen - (2 * 30)
//        return width
//    }
//}
//
//struct CardView: View {
//    var category: Category
//    @Binding var scrolled: Int
//    var body: some View {
//        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
//
//            Image(category.image)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(category.id - scrolled ) * 50)
//                .cornerRadius(15)
//
//            CardFooter(category: category)
//
//        }
//        .offset(x: category.id - scrolled <= 2 ? CGFloat(category.id - scrolled) * 30 : 60)
//    }
//
//    func calculateWidth() -> CGFloat{
//        let screen = UIScreen.main.bounds.width - 50
//        let width = screen - (2 * 30)
//        return width
//    }
//
//}
