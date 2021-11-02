//
//  Note.swift
//  NOTAS WatchKit Extension
//
//  Created by marco rodriguez on 02/11/21.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
