//
//  QuestionController.swift
//  Party
//
//  Created by Deniz Ata Eş on 30.10.2022.
//

import Foundation
import FirebaseFirestore

class QuestionController: ObservableObject{
    @Published var questionList = [String]()
    @Published var loading: Bool = true
    
    
    func getQuestion(categoryName: String){
        
        let db = Firestore.firestore()
        
        db.collection("Questions").whereField("Category", isEqualTo: categoryName)
            .addSnapshotListener
        { querySnapshot, error in
            if  let  e = error{
                print("There is something wrong while loading data. Error : \(e.localizedDescription)")
            }else{
                if  let snapshot = querySnapshot
                {
                
                    self.loading = true
                    DispatchQueue.main.async {
                        self.questionList = snapshot.documents.map{ d in
                            return d["Question"] as? String ?? ""
                        }
                        self.loading = false
                        
                    }
                    
                }
            }
        }
    }
    
    func fetchData(categoryName: String) {
        let db = Firestore.firestore()
        
        db.collection("Questions").whereField("Category", isEqualTo: categoryName).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.questionList = documents.map{ d in
                return d["Question"] as? String ?? ""
            }
        }
    }
    
    func addData(categoryName: String, question:String)
    {
        let db = Firestore.firestore()
        
        db.collection("Questions").addDocument(data: [
            "Category":categoryName,
            "Question":question
        ]) { (error) in
            if let e = error{
                print("there was a error, \(e.localizedDescription)")
            }
            else
            {
                print("success")
            }
        }
    }
    
    func deleteData(question:String)
    {
        let db = Firestore.firestore()
        db.collection("Questions").whereField("Question", isEqualTo: question).getDocuments{(snap, err) in
            if err != nil{
                print("error")
                return
            }
            
            for i in snap!.documents{
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
            
            
        }
        // Remove the post from the DB
//        ref.child("posts").child(postId).removeValue { error in
//          if error != nil {
//              print("error \(error)")
//          }
//        }
        
    }

    
}
