proc rebase {inputBase digits outputBase} {
    # Kiểm tra điều kiện cơ số hợp lệ
    if {$inputBase < 2} { error "input base must be >= 2" }
    if {$outputBase < 2} { error "output base must be >= 2" }

    # Đổi từ cơ số nguồn -> Hệ thập phân (base 10)
    set dec 0
    foreach d $digits {
        if {$d < 0 || $d >= $inputBase} { 
            error "all digits must satisfy 0 <= d < input base" 
        }
        set dec [expr {$dec * $inputBase + $d}]
    }

    # Trường hợp đặc biệt: Nếu giá trị bằng 0
    if {$dec == 0} { return {0} }

    # Đổi từ Hệ thập phân -> Cơ số đích
    set res {}
    while {$dec > 0} {
        set res [linsert $res 0 [expr {$dec % $outputBase}]]
        set dec [expr {$dec / $outputBase}]
    }

    return $res
}