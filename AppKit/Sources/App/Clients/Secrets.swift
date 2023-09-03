// Secrets.swift.gyb
enum Secrets {
    private static let salt: [UInt8] = [
        0x27, 0x92, 0x95, 0x1d, 0x96, 0xb7, 0x9a, 0xe7, 
        0x0c, 0x09, 0x4a, 0xcd, 0x85, 0xe5, 0xbc, 0x4a, 
        0x64, 0x18, 0xd0, 0xd8, 0x9d, 0x1e, 0x28, 0x1c, 
        0xda, 0xed, 0xda, 0xb7, 0x60, 0x36, 0xfb, 0xed, 
        0x88, 0x15, 0x90, 0xbb, 0x1a, 0xdc, 0xe4, 0x17, 
        0xc1, 0x9c, 0xb5, 0xe9, 0x0c, 0x40, 0x97, 0x0a, 
        0x21, 0xdb, 0xc1, 0xb1, 0x50, 0x9a, 0xc5, 0x4b, 
        0x84, 0x9a, 0x5d, 0xa0, 0x10, 0x53, 0x3f, 0xa4, 
    ]

    static var BACKEND_URL: String {
        let encoded: [UInt8] = [
        ]

        return decode(encoded, cipher: salt)
    }
    static var API_KEY: String {
        let encoded: [UInt8] = [
        ]

        return decode(encoded, cipher: salt)
    }

    static func decode(_ encoded: [UInt8], cipher: [UInt8]) -> String {
        String(decoding: encoded.enumerated().map { (offset, element) in
            element ^ cipher[offset % cipher.count]
        }, as: UTF8.self)
    }
}





