//
//  MainControler.swift
//  Facebook2020
//
//  Created by Mac on 9/1/20.
//  Copyright © 2020 Macify. All rights reserved.
//

import UIKit
import LBTATools

class PostCell: LBTAListCell<String> {
    
    let imageView = UIImageView(backgroundColor: .red)
    let nameLabel = UILabel(text: "Name Label")
    let dateLabel = UILabel(text: "Friday at 11.11AM")
    let postTextLabel = UILabel(text: "Here is my post text" )
    
   // let imageViewGrid = UIView(backgroundColor: .yellow)
    let photoGridController = PhotoGridController()
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(hstack(imageView.withHeight(40).withWidth(40),stack(nameLabel, dateLabel),spacing: 8).padLeft(12).padRight(12),
              postTextLabel,
              photoGridController.view,
              spacing: 8)
        
    }
}

class StoryHeader: UICollectionReusableView {
    
    let storiesController = StoriesController(scrollDirection: .horizontal)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        stack(storiesController.view)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}



class StoryPhotoCell: LBTAListCell<String> {
    
    override var item: String!{
        didSet{
            imageView.image = UIImage(named: item)
        }
    }
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Dragon Hero", font: .boldSystemFont(ofSize: 14), textColor: .white)
    
    override func setupViews() {
        backgroundColor = .red
        imageView.layer.cornerRadius = 10
        stack(imageView)
        setupGradientLayer()
        stack(UIView(), nameLabel).withMargins(.allSides(8))
    }
    let gradientLayer = CAGradientLayer()
    fileprivate func setupGradientLayer() {
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.1]
        layer.cornerRadius = 10
        clipsToBounds = true
        
        layer.addSublayer(gradientLayer)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
}
class StoriesController: LBTAListController<StoryPhotoCell, String>,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: view.frame.height - 24)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["dragon","hero6","dragon","hero6","dragon","hero6"]
    }
}

class storyHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
class MainController: LBTAListHeaderController<PostCell, String, StoryHeader>, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        
        self.items = ["hello","WORLD","1","2"]
        
        setupNavBar()
    }
    
    let fbLogoImageView = UIImageView(image: UIImage(named: "facebook"), contentMode: .scaleAspectFit)
    
    
    fileprivate func setupNavBar() {
        let width = view.frame.width - 120 - 16 - 60
        
        let titleView = UIView(backgroundColor: .clear)
       // titleView.frame = .init(x: 0, y: 0, width: width, height: 50)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 50)
        
        let searchButton = UIButton(title: "Search", titleColor: .black)
        
        titleView.hstack(fbLogoImageView.withWidth(120), UIView(backgroundColor: .clear).withWidth(width),searchButton.withWidth(60))
        
        navigationItem.titleView = titleView
    }
    override func scrollViewDidScroll( _ scrollView: UIScrollView) {
            let magicalSafeAreaTop: CGFloat = 88
            print(scrollView.contentOffset.y)
            
            let offset = scrollView.contentOffset.y + magicalSafeAreaTop
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + magicalSafeAreaTop) / magicalSafeAreaTop)
        
//         [fbLogoImageView, searchButton].forEach{$0.alpha = alpha}
//        
//        navigationController?.navigationBar.transform = init(translationX: 0, y: min(0, -offset))
//        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 400)
    }
}
import SwiftUI
struct MainPreview: PreviewProvider {
    static var previews: some View {
        //Text("MainPreview")
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
            return UINavigationController(rootViewController: MainController())
        }
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
        }
    }
}
