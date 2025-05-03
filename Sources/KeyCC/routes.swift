import Vapor
import Crypto
func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    app.get("generate-and-send") { req async throws -> Response in
            let privateKey = P256.Signing.PrivateKey()
            let rawPrivateKey = privateKey.rawRepresentation.base64EncodedString()
            let rawPublicKey = privateKey.publicKey.rawRepresentation.base64EncodedString()

            let walletKey = WalletKey(publicKey: rawPublicKey, privateKey: rawPrivateKey)
            let javaBackendURL = URI(string: "http://localhost:8080/api/wallet/import")

            _ = try await req.client.post(javaBackendURL) { postReq in
                try postReq.content.encode(walletKey, as: .json)
            }

            let responseBody: [String: String] = [
                "status": "Wallet imported",
                "publicKey": rawPublicKey,
                "rawPrivateKey": rawPrivateKey
            ]

            let res = Response()
            try res.content.encode(responseBody, as: .json)
            return res
        }
    }
