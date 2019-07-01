//
//  ChatsModel.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 30.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI

struct ChatsModel: Identifiable {
    var id: Int
    var message: String
    var uidFromFirebase: String
    var messageFrom: String
    var messageTo: String
    var messageFromMe : Bool
    var messageDate : Date
}

//var testChatArray = [ChatsModel(id: 0, message: "aa", uidFromFirebase: "bb"),ChatsModel(id: 1, message: "bb", uidFromFirebase: "cc")]
