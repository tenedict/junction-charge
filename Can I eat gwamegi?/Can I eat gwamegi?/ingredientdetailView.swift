//
//  ingredientdetailView.swift
//  Can I eat gwamegi?
//
//  Created by 문재윤 on 8/10/24.
//

import SwiftUI

struct DetailView: View {
    var response: String
    
    var body: some View {
        VStack {
            Text("응답 결과:")
                .font(.headline)
                .padding()
            
            Text(response)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
