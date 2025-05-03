import Vapor

struct WalletKey: Content {
    let publicKey: String
    let privateKey: String
}
