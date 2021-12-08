//
//  ContentView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    
    let screens = ["Searcher", "Test Data Viewer"]
    
    @State var dataType: DataType = .live
    @State var screenTitle: String? = "Searcher"
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(tag: screens[0], selection: $screenTitle) {
                    SearcherListView(dataType: $dataType)
                } label: {
                    Label("Searcher", systemImage: "magnifyingglass")
                }
                NavigationLink(tag: screens[1], selection: $screenTitle) {
                    TestDataView(dataType: $dataType)
                } label: {
                    Label("Test Data Viewer", systemImage: "list.bullet.rectangle")
                }
            }
            .listStyle(.sidebar)
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
            ToolbarItemGroup(placement: .primaryAction) {
              Menu {
                  ForEach(DataType.allCases, id: \.self) { testData in
                      Button {
                          self.dataType = testData
                      } label: {
                          Image(systemName: testData.imageName)
                          Text("\(testData.title)")
                      }
                  }
                } label: {
                    Image(systemName: dataType.imageName)
                }
                .help("Select the type of data you want to use")
            }
        }

    }
    
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
