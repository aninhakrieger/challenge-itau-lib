//
//  SendInformationGateway.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import Foundation
import ItauAPIFramework

class SendInformationGateway {
    
    static let shared = SendInformationGateway()
    
    private init(){}
    
    func postSendInformation(data: MobileInfo, completed: @escaping (Result<InfoResponse, ItauError>) -> Void) {
        ItauService.shared.post(body: data.dictionary) { result in
            switch result {
            case .success(let data):
                do{
                    guard let data = data else {
                        completed(.failure(.invalidData))
                        return
                    }
                    completed(.success(try JSONDecoder().decode(InfoResponse.self, from: JSONSerialization.data(withJSONObject: data))))
                } catch {
                    completed(.failure(.invalidData))
                }
            case .failure(_):
                completed(.failure(.unableToComplete))
            }
        }
    }
}
