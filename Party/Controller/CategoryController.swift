//
//  CategoryController.swift
//  Party
//
//  Created by Deniz Ata Eş on 28.10.2022.
//

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
                            
                            return Category(id: d.documentID,
                                            name: d["Name"] as? String ?? "",
                                            description: d["Description"] as? String ?? "",
                                            image: d["Image"] as? String ?? "",
                                            price: d["Price"] as? String ?? "")
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
