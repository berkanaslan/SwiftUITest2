//
//  ChatView.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 29.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatView : View {
    
    let db = Firestore.firestore()

    
    @State var messageToSend = ""

    var userToChat : Users
    @ObjectBinding var chatArray = ChatStore()

    
    var body: some View {
        
        VStack{
            
            ScrollView{
                ForEach(chatArray.chatArray) { chats in
                    ChatRow(chatMessage: chats,userToChatFromChatView: self.userToChat)
                }
            }
   
           /* List(chatArray.chatArray) { chats in
                
                ChatRow(chatMessage: chats,userToChatFromChatView: self.userToChat)
            }
 */
            
        HStack{
            TextField($messageToSend, placeholder: Text("Message here...")).frame(minHeight: 30)
            
            Button(action: sendMessageToFirebase) {
                Text("Send")
                }.frame(minHeight:50).padding()
        }
            }
    }
    
    func sendMessageToFirebase() {
        var ref: DocumentReference? = nil
        
        var myDictionaryToCurrentUser : [String : Any] = ["chatUserFrom": Auth.auth().currentUser!.uid, "chatUserTo": userToChat.uidFromFirebase,"date":generateCurrentTimeStamp(),"message":self.messageToSend]
        
        ref = self.db.collection("Chats").addDocument(data: myDictionaryToCurrentUser, completion: { (error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.messageToSend = ""
            }
        })
        
        
    }
    
    func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
}



#if DEBUG
struct ChatView_Previews : PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: Users(id: 0,name: "Sample User", uidFromFirebase: "aaaa"))
        
    }
}
#endif

