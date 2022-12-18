//
//  ItauError.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import Foundation

enum ItauError: String, Error {
    case invalidData = "Invalid response from the server. Please try again."
    case unableToComplete = "Não foi possível completar sua solicitação."
}
