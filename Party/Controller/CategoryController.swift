import Foundation
import FirebaseFirestore

class CategoryController: ObservableObject{
    @Published var categoryList = [Category]()
    @Published var state: State = .loading
    
    enum State {
        case loading
        case loaded
    }
    
    
    func getCategories(){
        let db = Firestore.firestore()
        state = .loading
        db.collection("Categories").getDocuments{ snapshot, error in
            
            if error == nil {
                if let snapshot = snapshot
                {
                    DispatchQueue.main.async {
                        self.categoryList = snapshot.documents.map{ d in
                            
                            return Category(id: d["id"] as? Int ?? 0,
                                            name: d["Name"] as? String ?? "",
                                            description: d["Description"] as? String ?? "",
                                            image: d["Image"] as? String ?? "",
                                            isPriced: d["isPriced"] as? Bool ?? false)
                        }
                        self.state = .loaded
                    }
                    
                    
                }
            }else{
                print("Error Fetching Categories")
                
            }
        }
        
    }
}
