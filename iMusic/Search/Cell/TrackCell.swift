//
//  TrackCell.swift
//  iMusic
//
//  Created by RAFAEL on 04.06.2023.
//

import UIKit
import SDWebImage


protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}


class TrackCell: UITableViewCell {
    
    static let reuseId = "TrackCell"
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    var cell: SearchViewModel.Cell?
    
    func set(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    
    @IBAction func addTrackAction(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: cell, requiringSecureCoding: false) {
            print("Success!!!")
            defaults.setValue(savedData, forKey: "tracks")
        }
    }
    
    @IBAction func showInfoAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        if let savedTrack = defaults.object(forKey: "tracks") as? Data {
            if let decodedTracks = try?
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTrack) as? SearchViewModel.Cell {
                print("decodedTracks.trackName : \(decodedTracks.trackName)")
                
            }
        }
    }
}
