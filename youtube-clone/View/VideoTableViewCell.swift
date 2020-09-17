//
//  VideoTableViewCell.swift
//  youtube-clone
//
//  Created by Stefan Hitrov on 16.09.20.
//  Copyright © 2020 Stefan Hitrov. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v: Video) {
        self.video = v
        
        guard self.video != nil else {
            return
        }
        
        // Set the title and date label
            self.titleLabel.text = video?.title
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE, MMM, d, yyyy"
        self.dateLabel.text = dateFormat.string(from: video!.published)
        
        // Set the thumbnail
        guard self.video?.thumbnail != "" else {
            return
        }
        
        // Check cache before downlaoding data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            // Set the thumbnail imageView
            self.thumbnailImageView.image = UIImage(data: cachedData)
            
            return
        }
        
        // Download thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        // Get the session URL session object
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Check that the download url matches the video thumbnail url that this cell is currently se to display
                if url?.absoluteString != self.video?.thumbnail {
                    return
                }
                
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set the imageView
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        // Start data task
        dataTask.resume()
        
        
    }

}
