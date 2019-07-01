//
//  ChatRow.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 30.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatRow : View {
    
    var chatMessage : ChatsModel
    var userToChatFromChatView : Users
    
    var body: some View {
        Group{
            if chatMessage.messageFrom == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChatFromChatView.uidFromFirebase {
                HStack{
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(Color.black)
                        .padding(10)
                    Spacer()
                }
            } else if chatMessage.messageFrom == userToChatFromChatView.uidFromFirebase &&  chatMessage.messageTo == Auth.auth().currentUser!.uid {
                VStack(alignment:.trailing) {
                    HStack{
                        Spacer()
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(10)
                        
                        }
                    }
            }else {

            }
        
        }.frame(width: UIScreen.main.bounds.width * 0.95)
}

#if DEBUG
struct ChatRow_Previews : PreviewProvider {
    static var previews: some View {
        Group{
            ChatRow(chatMessage: ChatsModel(id: 0, message: "test message", uidFromFirebase: "aa", messageFrom: "bb", messageTo: "cc", messageFromMe: true, messageDate: Date()), userToChatFromChatView: Users(id: 0, name: "Atil", uidFromFirebase: "aaa"))
        }.previewLayout(.fixed(width: 300, height: 80))
    }
}
#endif
}
