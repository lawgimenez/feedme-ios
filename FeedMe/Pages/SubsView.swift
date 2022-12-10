//
//  SubsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct SubsView: View {
    
    @EnvironmentObject private var subsOversable: SubsObservable
    
    var body: some View {
        VStack {
            let _ = print("SubsView count = \(subsOversable.arraySubs.count)")
            List(subsOversable.arraySubs) { sub in
                Text(sub.title)
            }
        }
    }
}

struct SubsView_Previews: PreviewProvider {
    static var previews: some View {
        SubsView()
    }
}
