proc encrypt {plaintext} {
    # Chuẩn hóa: Loại bỏ tất cả dấu câu & khoảng trắng, chuyển thành chữ viết thường
    set cleaned_plaintext [string tolower [regsub -all {[^a-zA-Z0-9]} $plaintext ""]]
    set len [string length $cleaned_plaintext]

    # Nếu chuỗi rỗng thì trả về ngay chuỗi rỗng
    if {$len == 0} {
        return ""
    }

    # Tìm số hàng (r) và số cột (c) nhỏ nhất thỏa mãn r * c >= len và c >= r
    set r 1
    set c 1
    while {$r * $c < $len} {
        if {$c > $r} {
            incr r
        } else {
            incr c
        }
    }

    # Đệm thêm khoảng trắng vào cuối chuỗi cho đủ độ dài r * c
    set target_len [expr {$r * $c}]
    while {[string length $cleaned_plaintext] < $target_len} {
        append cleaned_plaintext " "
    }

    # Đọc ký tự theo cột từ trái sang phải
    set chunks {}
    for {set col 0} {$col < $c} {incr col} {
        set chunk ""
        for {set row 0} {$row < $r} {incr row} {
            set idx [expr {$row * $c + $col}]
            append chunk [string index $cleaned_plaintext $idx]
        }
        lappend chunks $chunk
    }

    # Ghép các khối lại bằng 1 dấu cách
    return [join $chunks " "]
}
