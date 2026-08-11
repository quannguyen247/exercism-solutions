proc largestSeriesProduct {digits span} {
    set len [string length $digits]

    # Kiểm tra các điều kiện 
    if {$span < 0} {
        error "span must not be negative"
    }
    if {$span > $len} {
        error "span must not exceed string length"
    }
    if {$digits ne "" && ![regexp {^[0-9]+$} $digits]} {
        error "digits input must only contain digits"
    }
    if {$span == 0} {
        return 1
    }

    # Thuật toán sliding window
    set max_prod 0

    for {set i 0} {$i <= $len - $span} {incr i} {
        # Cắt chuỗi con có độ dài bằng span
        set sub [string range $digits $i [expr {$i + $span - 1}]]

        # Tính tích các chữ số trong chuỗi con
        set prod 1
        foreach d [split $sub ""] {
            set prod [expr {$prod * $d}]
        }

        # Cập nhật tích lớn nhất
        if {$prod > $max_prod} {
            set max_prod $prod
        }
    }

    return $max_prod
}