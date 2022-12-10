//
//  SubsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct SubsView: View {
    
    @EnvironmentObject private var subsObservable: SubsObservable
    
    var body: some View {
        VStack {
            let _ = print("SubsView count = \(subsObservable.arraySubs.count)")
            List(subsObservable.arraySubs) { sub in
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
