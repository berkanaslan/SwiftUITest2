//
//  ChatStore.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 30.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//
import SwiftUI
import Firebase
import Combine

class ChatStore : BindableObject {
    
    let db = Firestore.firestore()
    var chatArray : [ChatsModel] = []
    
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        db.collection("Chats")
            .whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.chatArray.removeAll(keepingCapacity: false)
                for document in snapshot!.documents {
                    let chatUidFromFirebase = document.documentID
                    if let chatMessage = document.get("message") as? String {
                        if let messageFrom = document.get("chatUserFrom") as? String {
                            if let messageTo = document.get("chatUserTo") as? String {
                                
                                if let dateString = document.get("date") as? String {
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    let dateFromFB = dateFormatter.date(from: dateString)

                                    
                                    let currentIndex = self.chatArray.last?.id
                                    
                                    let createdChat = ChatsModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFirebase, messageFrom: messageFrom, messageTo: messageTo,messageFromMe: true,messageDate: dateFromFB!)
                                    self.chatArray.append(createdChat)
                                    
                                    
                                }
                                
                                
                            }
                        }
                    }
                }
                //self.didChange.send(self.chatArray)
                self.db.collection("Chats")
                    .whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid)
                    .addSnapshotListener { (snapshot, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            
                            for document in snapshot!.documents {
                                let chatUidFromFirebase = document.documentID
                                if let chatMessage = document.get("message") as? String {
                                    if let messageFrom = document.get("chatUserFrom") as? String {
                                        if let messageTo = document.get("chatUserTo") as? String {
                                            
                                            if let dateString = document.get("date") as? String {
                                                
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                                let dateFromFB = dateFormatter.date(from: dateString)
                                            
                                            let currentIndex = self.chatArray.last?.id
                                            
                                            let createdChat = ChatsModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFirebase, messageFrom: messageFrom, messageTo: messageTo,messageFromMe: false,messageDate: dateFromFB!)
                                            
                                            self.chatArray.append(createdChat)
                                    
                                            
                                            
                                            }
                                        }
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                            //self did change olayını for loop bittikten sonra yapıyoruz
                            //sıralamayı en son yapabiliriz
                            self.chatArray = self.chatArray.sorted(by: {
                                $0.messageDate.compare($1.messageDate) == .orderedDescending
                            })
                            
                            self.didChange.send(self.chatArray)

                            
                        }
                }

              
            }
        }
        
        
        }
        
        
    }
    

