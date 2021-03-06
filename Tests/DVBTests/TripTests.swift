import Foundation
import XCTest
import DVR
@testable import DVB

class TripTests: XCTestCase {
    func testTripLocation3FromAlpAtHbf() {
        let e = expectation(description: "Find a trip")

        let session = Session(cassetteName: #function)

        let tripId = "66230687" // This was chosen manually :/ For reference: It's an upcoming 3 departure at Albertplatz headed towards Coschütz
        let hauptbahnhof = "33000028"
        let date = Date(timeIntervalSince1970: 1490561874) // 2016-03-26 22:57:54

        TripStop.get(forTripID: tripId, stopID: hauptbahnhof, atTime: date, session: session) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failed with error: \(error)")
            case .success(let response):
                guard response.stops.count > 0 else {
                    XCTFail("Found no trip stops")
                    return
                }
                e.fulfill()
            }
        }

        waitForExpectations(timeout: 5)
    }
}
