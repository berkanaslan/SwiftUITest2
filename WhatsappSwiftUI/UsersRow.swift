//
//  UsersRow.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 28.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI

struct UsersRow : View {
    
    var user : Users
    
    var body: some View {
        HStack{
            Text(user.name)
        }
    }
}

#if DEBUG
struct UsersRow_Previews : PreviewProvider {
    static var previews: some View {
        Group{
            UsersRow(user: Users(id: 0, name: "Sample User", uidFromFirebase: "aaaa"))
        }.previewLayout(.fixed(width: 300, height: 80))
    }
}
#endif
