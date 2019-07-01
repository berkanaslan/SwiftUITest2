//
//  UserStore.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 29.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class UserStore : BindableObject {
    
    let db = Firestore.firestore()
    var userArray : [Users] = []
    
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        
        db.collection("Users").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
            self.userArray.removeAll(keepingCapacity: false)
                for document in snapshot!.documents {
                    if let userUidFromFirebase = document.get("useruidfromfirebase") as? String {
                        if let userName = document.get("username") as? String {
                            let currentIndex = self.userArray.last?.id
                            let createdUser = Users(id: (currentIndex ?? -1) + 1, name: userName, uidFromFirebase: userUidFromFirebase)
                            self.userArray.append(createdUser)
                        }
                        
                    }
                    
                }
                self.didChange.send(self.userArray)

            }
        }
        

    }
    
}
