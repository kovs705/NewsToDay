//
//  ImageClient.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 19.05.2023.
//

import UIKit

protocol ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (Result<UIImage, Error>) -> Void)
    func setImage(from url: String?, completion: @escaping (UIImage?) -> Void)
}

final class ImageClient {
    
    static let shared = ImageClient()
    
    //    private(set) var cachedImageFor: [String: UIImage]
    private var cachedImageFor = NSCache<NSString, UIImage>()
    //    private(set) var cachedTaskForImageView: [UIImageView : NetworkService]
    
    let responseQueue = DispatchQueue.main
    let requestQueue = DispatchQueue(label: "com.pacanivoobsherebyate",
                                     qos: .utility, attributes: .concurrent)
    let session = URLSession.shared
    let placeholderImage = UIImage(named: "placeholderImage")
    
    private init() {}
}

extension ImageClient: ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request,
                                             completion: @escaping (Result<UIImage, Error>) -> Void) {
        let service = DefaultNetworkService()
        
        requestQueue.async {
            service.request(request) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        guard let image: UIImage = response as? UIImage else {
                            return
                        }
                        completion(.success(image))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func setImage(from url: String?,
                  completion: @escaping (UIImage?) -> Void) {
        guard let url else { return }
        let request = ImageRequest(url: url)
        
        if let cacheImage = cachedImageFor.object(forKey: url as NSString) {
            completion(cacheImage)
        } else {
            downloadImage(request: request) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.cachedImageFor.setObject(image, forKey: url as NSString)
                    completion(image)
                case .failure(_):
                    completion(self?.placeholderImage)
                    return
                }
            }
        }
    }
}
