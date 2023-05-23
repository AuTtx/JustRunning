/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Utility views and functions.
*/

import SwiftUI



struct Transaction: Identifiable, Hashable {
    let id = UUID()
}

/// A few fake transactions for display.
let transactions = [
    Transaction(),
    Transaction(),
    Transaction(),
    Transaction(),
    Transaction(),
    Transaction(),
    Transaction(),
    Transaction()
]

struct TransactionsLink: View {
    var body: some View {
        NavigationLink("Show Transactions", value: transactions)
    }
}

struct TransactionsView: View {
    let transactions: [Transaction]

    var body: some View {
        List {
            ForEach(transactions) { _ in
                HStack { Text("Year Month Day"); Text("Style"); Spacer(); Text("123") }
            }
        }
        .redacted(reason: .placeholder)
        .navigationTitle("Transactions")
    }
}
