@usableFromInline
func matmul_internal<T: Numeric>(lhs: [T], rhs: [T], m: Int, n: Int, p: Int) -> [T] {
    assert(lhs.count == m*p)
    assert(rhs.count == p*n)
    
    var ret = [T](repeating: 0, count: m*n)
    
    lhs.withUnsafeBufferPointer { lbp in
        rhs.withUnsafeBufferPointer { rbp in
            ret.withUnsafeMutableBufferPointer { bp in
                var lp = lbp.baseAddress!
                for i in 0..<m {
                    var rp = rbp.baseAddress!
                    for _ in 0..<p {
                        var pp = bp.baseAddress! + n*i
                        for _ in 0..<n {
                            pp.pointee += lp.pointee * rp.pointee
                            
                            pp += 1
                            rp += 1
                        }
                        lp += 1
                    }
                }
            }
        }
    }
    
    return ret
}

@inlinable
public func matmul_inlinable<T: Numeric>(lhs: [T], rhs: [T], m: Int, n: Int, p: Int) -> [T] {
    return matmul_internal(lhs: lhs, rhs: rhs, m: m, n: n, p: p)
}

public func matmul_specialize(lhs: [Double], rhs: [Double], m: Int, n: Int, p: Int) -> [Double] {
    return matmul_internal(lhs: lhs, rhs: rhs, m: m, n: n, p: p)
}
