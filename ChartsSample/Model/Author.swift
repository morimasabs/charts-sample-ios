//
//  Author.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import Foundation

struct Author: Identifiable {
    let id: UUID = UUID()
    let name: String
    
    static var example = Author(name: "George R. R. Martin")
    
    static var examples = [
        Author(name: "J.K. Rowling"),
        Author(name: "George R. R. Martin"),
        Author(name: "J.R.R. Tolkien"),
        Author(name: "Agatha Christie"),
        Author(name: "Stephen King"),
        Author(name: "Dan Brown"),
        Author(name: "Harper Lee"),
        Author(name: "Jane Austen"),
        Author(name: "F. Scott Fitzgerald"),
        Author(name: "Ernest Hemingway")
    ]
}
