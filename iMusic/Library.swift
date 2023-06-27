//
//  Library.swift
//  iMusic
//
//  Created by RAFAEL on 22.06.2023.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAllert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .tint(.red)
                                .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        }
                        Button {
                            self.tracks = UserDefaults.standard.savedTracks()
                        } label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .tint(.red)
                                .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        }
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                // Spacer()
                List {
                    ForEach (tracks) { track in
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded({ _ in
                                    print("Pressed!")
                                    self.track = track
                                    self.showingAllert = true
                                })
                                .simultaneously(with: TapGesture()
                                    .onEnded({ _ in
                                        self.track = track
                                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                                    })))
                    }.onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showingAllert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this track?"),
                            buttons: [.destructive(Text("Delete"), action: {
                    print("Deleting \(self.track.trackName)")
                    self.delete(track: self.track)
                }), .cancel()
                                     ])
            })
            .navigationTitle("Library")
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
}


struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        let url = URL(string: cell.iconUrlString!)!
        HStack {
            URLImage(url) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
