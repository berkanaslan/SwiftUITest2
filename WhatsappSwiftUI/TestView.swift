//
//  TestView.swift
//  WhatsappSwiftUI
//
//  Created by Atil Samancioglu on 28.06.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI

struct TestView : View {
    @State var x = true;

    var body: some View {
        NavigationView {
            if x {
                Text("Hello")
                Button(action: {
                    self.x = false;
                }, label: { Text("Click Me") })
            } else {
                Text("World")
            }
        }
    }
}

#if DEBUG
struct TestView_Previews : PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
#endif
