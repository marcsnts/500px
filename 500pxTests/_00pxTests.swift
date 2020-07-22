//
//  _00pxTests.swift
//  500pxTests
//
//  Created by Marc Santos on 2020-07-12.
//  Copyright © 2020 Marc Santos. All rights reserved.
//

import XCTest
@testable import _00px

class _00pxTests: XCTestCase {
    func testInitPhotoFromJSON() {
        // Convert JSON file contents to dictionary
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "photo", ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        let jsonData = jsonString.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        
        let photo = Photo(from: json)
        XCTAssertEqual(photo.name, "Tapping into the Reserve")
        XCTAssertEqual(photo.numComments, 57)
        XCTAssertEqual(photo.numLikes, 1258)
        XCTAssertEqual(photo.author, "Ole Henrik Skjelstad")
        XCTAssertEqual(photo.authorAvatarURL, "https://drscdn.500px.org/user_avatar/4526460/q%3D85_w%3D300_h%3D300/v2?webp=true&v=5&sig=2d7d97b2a7494564ffcec17050ccde43ca91dcf94d43d94cdc4c21f50d7750eb")
        XCTAssertEqual(photo.imageURL, "https://drscdn.500px.org/photo/1018488481/q%3D50_h%3D450/v2?sig=1967560270f61495b6801d0806f0ea4ca18ac3f979bac1aef428aeb42e645a28")
    }
    
    func testImageCaching() {
        let imageCached = expectation(description: "Image Cached")
        let stubURL = "https://drscdn.500px.org/user_avatar/4526460/q%3D85_w%3D300_h%3D300/v2?webp=true&v=5&sig=2d7d97b2a7494564ffcec17050ccde43ca91dcf94d43d94cdc4c21f50d7750eb"
        
        // Check if image is cached - should not be cached from the start
        XCTAssertFalse(CacheManager.shared.isImageCached(stubURL))
        CacheManager.shared.loadImage(urlString: stubURL) { _ in
            // Should be cached because `loadImage` caches all images downloaded
            let isCached = CacheManager.shared.isImageCached(stubURL)
            XCTAssertTrue(isCached)
            imageCached.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
}
