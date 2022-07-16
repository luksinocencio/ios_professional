import Foundation
import UIKit

enum NetworkError: String, Error {
    case serverError = "Ensure you are connected to the internet. Please try again."
    case decodingError = "We could not process your request. Please try again."
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryViewController {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }

            do {
                let profile = try JSONDecoder().decode(Profile.self, from: data)
                completion(.success(profile))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Double
    let createdDateTime: Date

    static func makeSkeleton() -> Account {
        return Account(id: "`", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }
}

extension AccountSummaryViewController {
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
//        guard let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
//                    return
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .iso8601
//
//                    let accounts = try decoder.decode([Account].self, from: data)
//                    completion(.success(accounts))
//                } catch {
//                    completion(.failure(.decodingError))
//                }
//            }
//        }.resume()
    }
}
