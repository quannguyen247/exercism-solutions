proc rebase {inputBase digits outputBase} {
    # Kiểm tra cơ số phải >= 2
    if {$inputBase < 2} { error "input base must be >= 2" }
    if {$outputBase < 2} { error "output base must be >= 2" }

    # Đổi dãy chữ số ở cơ số nguồn -> Hệ thập phân (base 10)
    set decimal 0
    foreach digit $digits {
        if {$digit < 0 || $digit >= $inputBase} {
            error "all digits must satisfy 0 <= d < input base"
        }
        set decimal [expr {$decimal * $inputBase + $digit}]
    }

    # Xử lý  trường hợp số 0
    if {$decimal == 0} {
        return {0}
    }

    # Đổi từ hệ thập phân -> Dãy chữ số ở cơ số đích
    set result {}
    while {$decimal > 0} {
        set remainder [expr {$decimal % $outputBase}]
        set result [linsert $result 0 $remainder]
        set decimal [expr {$decimal / $outputBase}]
    }

    # Trả về kết quả danh sách chữ số mới
    return $result
}