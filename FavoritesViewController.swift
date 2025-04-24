//
//  FavoritesViewController.swift
//  PlaylistApp
//
//  Created by James Flynn on 12/17/24.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var favorites: [(artist: String, song: String, cover: UIImage?)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        favorites = appDelegate.favorites
        
      
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        
      
        cell.textLabel?.text = "\(favorite.song) - \(favorite.artist)"
        cell.imageView?.image = favorite.cover
        
        return cell
    }
}
