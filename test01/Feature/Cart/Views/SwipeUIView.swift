import SwiftUI

struct SwipeActionView: View {
    @State private var actionTitle = ""
    @State private var isEditing = false  // 편집 모드 상태를 추적하는 변수

    var body: some View {
        NavigationView {
            List {
                ForEach(1..<10) { num in
                    Text("Number is \(num)")
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            if isEditing {  // 편집 모드일 때만 표시
                                Button { actionTitle = "Counting Star" } label: {
                                    Label("Star", systemImage: "star.circle")
                                }
                                .tint(.green)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            if isEditing {  // 편집 모드일 때만 표시
                                Button(role: .destructive) {
                                    actionTitle = "Move the trash"
                                } label: {
                                    Label("Trash", systemImage: "trash.circle")
                                }
                                .tint(.red)
                                Button {
                                    actionTitle = "Pick the flag"
                                } label: {
                                    Label("Flag", systemImage: "flag.circle")
                                }
                                .tint(.blue)
                            }
                        }
                }
            }
            .navigationTitle("\(actionTitle)")
            .navigationBarTitle("장바구니", displayMode: .automatic)
            .navigationBarItems(leading: Button(action: {
                isEditing.toggle()  // 편집 모드 상태를 토글
            }) {
                VStack {
                    Image(systemName: "gearshape.fill")
                    Text(isEditing ? "확인" : "편집")  // 편집 모드 상태에 따라 텍스트 변경
                        .font(.system(size: 12))
                }
                .foregroundColor(.blue)
            })
        }
    }
}

struct SwipeActionView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionView()
    }
}
