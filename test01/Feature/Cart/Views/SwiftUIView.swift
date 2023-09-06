import SwiftUI

struct SwipeButtonDemoView: View {
  let listItems = WWDCViewModel().sessions
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        
        List {
          ForEach(listItems) { session in
            HStack {
              Image(systemName: "play")
              Text(session.title)
                .font(.callout)
            }
            .swipeActions(edge: .leading) {
              Button {
                print("Bookmark")
              } label: {
                Label("Bookmark", systemImage: "bookmark")
              }.tint(.indigo)
            }
          }
          .listRowSeparator(.hidden)
          }
        }
      .listStyle(.inset)
      .navigationTitle("WWDC 21")
    }
  }
}
 

struct SwipeButtonDemoView_Previews: PreviewProvider {
  static var previews: some View {
    SwipeButtonDemoView()
  }
}
