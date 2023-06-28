//
//  FavoritePokemonsViewController.swift
//  obligatorio-final
//
//  Created by Manuela Garcia Lira on 22/6/23.
//

import Foundation
import UIKit



class FavoritePokemonsViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var pokemonScrollView: UIScrollView!
    @IBOutlet weak var viewTiteleLabel: UILabel!
    @IBOutlet weak var pageControlByScrolView: UIPageControl!
    
    var pages : [ViewExample] {
        get {
            let page1: ViewExample = Bundle.main.loadNibNamed("ViewExample", owner: self, options: nil)?.first as! ViewExample
            page1.view.backgroundColor = UIColor.blue
            page1.imagePokemon.image = UIImage(named: "pokeImage")
            
            let page2: ViewExample = Bundle.main.loadNibNamed("ViewExample", owner: self, options: nil)?.first as! ViewExample
            page2.view.backgroundColor = UIColor.green
            page2.imagePokemon.image = UIImage(named: "pokeImage")
            
            let page3: ViewExample = Bundle.main.loadNibNamed("ViewExample", owner: self, options: nil)?.first as! ViewExample
            page3.view.backgroundColor = UIColor.gray
            page3.imagePokemon.image = UIImage(named: "pokeImage")
            
            let page4: ViewExample = Bundle.main.loadNibNamed("ViewExample", owner: self, options: nil)?.first as! ViewExample
            page4.view.backgroundColor = UIColor.yellow
            page4.imagePokemon.image = UIImage(named: "pokeImage")
            
            let page5: ViewExample = Bundle.main.loadNibNamed("ViewExample", owner: self, options: nil)?.first as! ViewExample
            page5.view.backgroundColor = UIColor.purple
            page5.imagePokemon.image = UIImage(named: "pokeImage")
            
            return [page1, page2, page3, page4, page5]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTiteleLabel.text = "Favorites"
        headerImage.image = UIImage(named: "logo_v2")
        
        view.bringSubviewToFront(pageControlByScrolView)
        
        setupScrollView(pages: pages)
        
        pageControlByScrolView.numberOfPages = pages.count
        pageControlByScrolView.currentPage = 0
    }
 
    func setupScrollView(pages: [ViewExample]) {
        pokemonScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        pokemonScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
        pokemonScrollView.isPagingEnabled = true
        
        for i in 0 ..< pages.count {
            pages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            pokemonScrollView.addSubview(pages[i])
        }
    }
}

extension FavoritePokemonsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControlByScrolView.currentPage = Int(pageIndex)
    }
}

