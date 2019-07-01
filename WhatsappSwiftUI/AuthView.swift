//
//  ContentView.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 27.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI
import Firebase

struct AuthView : View {
    
        let db = Firestore.firestore()
    
    @EnvironmentObject var userArray : UserStore
        //@ObjectBinding var userArray = UserStore()
        @State var showAuthView = true
        @State var username = ""
        @State var password = ""
        @State var useremail = ""
    
        var body: some View {
            
            NavigationView{
                
                if showAuthView{
            //AuthView---START
            List {
                    Text("Whatsapp Clone")
                        .font(.largeTitle)
                        .bold()
                
                
                Section {
                    VStack(alignment: .leading) {
                        ControlTitle(title: "User Email")
                        TextField($useremail)
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        ControlTitle(title: "Password")
                        TextField($password)

                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        ControlTitle(title: "Username")
                        TextField($username)
                        
                    }
                }
                
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            Auth.auth().signIn(withEmail: self.useremail, password: self.password) { (result, error) in
                                if error != nil {
                                print(error?.localizedDescription)
                                } else {
                                    
                                    //USER SIGNED IN
                                    self.showAuthView = false
                                    
                                }
                            }
                        }) {
                            Text("Sign In")
                        }
                        Spacer()
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        
                        Button(action: {
                            Auth.auth().createUser(withEmail: self.useremail, password: self.password) { (result, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                } else {
                                    //USER CREATED
                                    
                                    var ref: DocumentReference? = nil
                                    
                                    var myDictionary : [String : Any] = ["username": self.username, "useremail": self.useremail,"useruidfromfirebase":result!.user.uid]
                                    
                                    ref = self.db.collection("Users").addDocument(data: myDictionary, completion: { (error) in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                        }
                                    })

                                    self.showAuthView = false
                                    
                                }
                            }
                            
                        }) {
                            Text("Sign Up")
                        }
                        Spacer()
                    }
                }
                
                
        
                
                }.listStyle(.grouped)
                    
                    //AuthView---END

                
                } else {
                    

                    //UsersView -- START
                    NavigationView{
                        
                        List(userArray.userArray) { user in
                            NavigationButton(destination: ChatView(userToChat: user)) {
                                UsersRow(user: user)
                            }
                            
                        }

                    }.navigationBarTitle(Text("Users To Chat"))
                        .navigationBarItems(leading: Button(action: {
                            
                            //LOG OUT
                            
                            self.showAuthView = true
                        }, label: {
                            Text("Log Out")
                        }))
                    //UsersView -- END

                }
                
            }
            
            
        }

    }



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            AuthView(showAuthView:false)
            AuthView(showAuthView:true)
        }
    }
}
#endif

struct ControlTitle : View {
    var title: String
    
    var body: some View {
        return Text(title).font(.subheadline).foregroundColor(.gray)
    }
}



