import XCTest
import inlinable_performance

final class inlinable_performanceTests: XCTestCase {
    
    let m = 300
    let n = 300
    let p = 300
    
    var lhs: [Double]!
    var rhs: [Double]!
    var answer: [Double]!
    
    override func setUp() {
        lhs = [Double](repeating: 0.1, count: m*p)
        rhs = [Double](repeating: 0.1, count: p*n)
        
        answer = matmul_specialize(lhs: lhs, rhs: rhs, m: m, n: n, p: p)
    }
    
    func testBase() {
        measure {
            let result = matmul_base(lhs: lhs, rhs: rhs, m: m, n: n, p: p)
            XCTAssertEqual(result[0], answer[0])
        }
    }
    
    func testInlinable() {
        measure {
            let result = matmul_inlinable(lhs: lhs, rhs: rhs, m: m, n: n, p: p)
            XCTAssertEqual(result[0], answer[0])
        }
    }
    
    func testSpecialize() {
        measure {
            let result = matmul_specialize(lhs: lhs, rhs: rhs, m: m, n: n, p: p)
            XCTAssertEqual(result[0], answer[0])
        }
    }
}
