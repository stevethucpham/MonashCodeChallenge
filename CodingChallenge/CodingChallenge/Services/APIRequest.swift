//
//  APIRequest.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/16/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//


import Foundation

/// API Error Exception
enum ApiError: Error {
    case serverError
    case serialization
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError:
            return NSLocalizedString("Something went wrong when requesting data", comment: "")
        case .serialization:
            return NSLocalizedString("Serialization error", comment: "")
        }
    }
}


// MARK: Network Result
enum ServiceResult<T> {
    case success(T)
    case failure(Error?)
}


// MARK: Tram Service Type
protocol APIRequestType {
    var session: URLSession { get }
    var token: String? { get set }
    
    func getSchedules(completion: @escaping (ServiceResult<Timetable?>) -> Void)
    
    
    /// This API request the API and decode the JSON Response
    /// - Parameters:
    ///   - url: API URL
    ///   - completionHandler: the completion handler which returns a decodable type if success, otherwise returns error.
    func request<T: Decodable> (from url: URL, completionHandler: @escaping (ServiceResult<T>) -> Void)
}

// MARK: Extension Tram Service Type
extension APIRequestType {
    /// This function requests the API and deserialize the JSON into the model
    /// - Parameters:
    ///   - url: API URL
    ///   - completionHandler: the completion handler which returns a decodable type if success, otherwise returns error.
    func request<T: Decodable> (from url: URL, completionHandler: @escaping (ServiceResult<T>) -> Void) {
        let task = session.dataTask(with: url) { data, response , error in
            
            guard let dataObject = data else { completionHandler(.failure(error)); return  }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(ApiError.serverError))
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: dataObject)
//                debugPrint(jsonResponse)
                completionHandler(.success(jsonResponse))
            } catch {
                completionHandler(.failure(ApiError.serialization))
            }
            
        }
        task.resume()
    }
}


// MARK: Tram Service Client
class APIRequest: APIRequestType {
    
    let session: URLSession
    var token: String?
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    
    init(session: URLSession, token: String? = nil) {
        self.session = session
        self.token = token
    }
    
    deinit {
        print("Service is deallocated")
    }
    
    
    func getSchedules(completion: @escaping (ServiceResult<Timetable?>) -> Void) {
        let url = URL(string: Constants.scheduleURL)!
        self.request(from: url) { (result: ServiceResult<Timetable>) in
            switch result {
            case .success(let response):
                completion(ServiceResult.success(response))
                break
            case .failure(let error):
                completion(ServiceResult.failure(error))
                break
            }
        }
    }

}
