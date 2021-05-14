
import UIKit

protocol HomeInteractorProtocol: class {
    @discardableResult
    func getMovies(withUrl urlString: String, completion: @escaping (Result<[Movie],Error>) -> Void) -> URLSessionTask
}

class HomeInteractor {
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    @discardableResult
    func getMovies(withUrl urlString: String, completion: @escaping (Result<[Movie], Error>) -> Void) -> URLSessionTask {

        return WebServiceManager.get(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: data)
                    completion(.success(movies.listOfMovies))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
