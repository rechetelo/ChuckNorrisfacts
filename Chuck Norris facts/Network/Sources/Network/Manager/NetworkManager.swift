//
//  NetworkManager.swift
//  Teste-BTG
//
//  Created by Recheteto Junior, Alvaro Jose on 12/10/20.
//  Copyright © 2020 Recheteto Junior, Alvaro Jose. All rights reserved.
//

import Foundation

//MARK: - Enum
enum NetworkResponse:String {
    case success
    case LOGIN_USER_ALREADY_EXISTS = "Já existe um usuário com este email"
    case LOGIN_PASSWORD_TOO_SHORT = "Senha muito curta"
    case LOGIN_INVALID_EMAIL = "Email inválido"
    case BAD_REQUEST = "Bad request"
    case NOT_FOUND = "Não encontrado."
    case UNEXPECTED_FAILURE = "Erro inesperado"
//    case MISSING_PARAMS = ""
    case LOGIN_WRONG_CREDENTIALS = "Email e/ou senha inválidos"
    case SERVER_UNREACHABLE = "Servidor inacessível"
    case NO_DATA = "Resposta retornada sem dados para decodificar."
    case UNABLE_TO_DECODE = "Não foi possível decodificar a resposta."
}

enum Result<String>{
    case success
    case failure(String)
}

//MARK: - Typealias
typealias ResultResponse<T> = (_ success: Bool, _ value: T?, _ error: Error?)-> Void

//MARK: - Struct
struct NetworkManager {
    
    //MARK: - Init
        init() {
        }
        
        //MARK: - Methods
        func statusCodeNetworkResponse(_ errorCode: Int) -> Result<String> {
            switch errorCode {
            case 100: return .failure(NetworkResponse.LOGIN_WRONG_CREDENTIALS.rawValue)
            case 101: return .failure(NetworkResponse.LOGIN_INVALID_EMAIL.rawValue)
            case 102: return .failure(NetworkResponse.LOGIN_PASSWORD_TOO_SHORT.rawValue)
            case 103: return .failure(NetworkResponse.LOGIN_USER_ALREADY_EXISTS.rawValue)
            case 200...299: return .success
            case 400: return .failure(NetworkResponse.BAD_REQUEST.rawValue) //BAD_REQUEST
            case 401: return .failure(NetworkResponse.NOT_FOUND.rawValue)
            case 404: return .failure(NetworkResponse.NOT_FOUND.rawValue)
            case 500: return .failure(NetworkResponse.UNEXPECTED_FAILURE.rawValue)
    //        case 1000: return .failure(NetworkResponse.MISSING_PARAMS.rawValue)  //MISSING_PARAMS
            default: return .failure(NetworkResponse.SERVER_UNREACHABLE.rawValue)
            }
        }
    
    func handleNetworkResponse(_ response: URLResponse? = nil, _ data: Data? = nil, _ error: Error? = nil) -> Result<String> {
        if let error = error {
            return Result.failure(error.localizedDescription)
        } else {
            guard let responseData = data else {
                return .failure(NetworkResponse.NO_DATA.rawValue)
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                        case 200...299: return .success
                    default:
                        return statusCodeNetworkResponse((jsonData as! [String:Any])["status"] as! Int)
                    }
                } else {
                    return .failure(NetworkResponse.SERVER_UNREACHABLE.rawValue)
                }

            } catch {
                print(error)
                return .failure(NetworkResponse.UNABLE_TO_DECODE.rawValue + "error:\(error.localizedDescription)")
            }
        }
    }
}
