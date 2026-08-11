proc transpose {lines} {
    set n [llength $lines]
    if {$n == 0} { 
        return {} 
    }

    # Tính độ dài đệm cần thiết cho từng dòng (quét từ dưới lên)
    set req_lens [lrepeat $n 0]
    set max_suffix 0
    for {set i [expr {$n - 1}]} {$i >= 0} {incr i -1} {
        set len [string length [lindex $lines $i]]
        if {$len > $max_suffix} { 
            set max_suffix $len 
        }
        lset req_lens $i $max_suffix
    }

    # Đệm khoảng trắng vừa đủ cho từng dòng
    set padded {}
    for {set i 0} {$i < $n} {incr i} {
        set line [lindex $lines $i]
        set req [lindex $req_lens $i]
        set len [string length $line]
        if {$len < $req} {
            append line [string repeat " " [expr {$req - $len}]]
        }
        lappend padded $line
    }

    # Rút các cột thành các hàng mới
    set result {}
    for {set c 0} {$c < $max_suffix} {incr c} {
        set col ""
        foreach line $padded {
            if {$c < [string length $line]} {
                append col [string index $line $c]
            }
        }
        lappend result $col
    }

    return $result
}