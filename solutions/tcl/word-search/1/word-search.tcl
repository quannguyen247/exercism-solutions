proc findWord {grid word} {
    set height [llength $grid]
    set width [string length [lindex $grid 0]]
    set length [string length $word]
    set directions {
         1  0  -1  0   0  1   0 -1
         1  1  -1 -1   1 -1  -1  1
    }

    # Thử từng ô và tám hướng
    for {set y 0} {$y < $height} {incr y} {
        for {set x 0} {$x < $width} {incr x} {
            if {[string index [lindex $grid $y] $x]
                ne [string index $word 0]} {
                continue
            }

            foreach {dx dy} $directions {
                set endX [expr {$x + $dx * ($length - 1)}]
                set endY [expr {$y + $dy * ($length - 1)}]

                # Điểm cuối phải nằm trong bảng
                if {$endX < 0 || $endX >= $width
                    || $endY < 0 || $endY >= $height} {
                    continue
                }

                set found true
                for {set i 1} {$i < $length} {incr i} {
                    set nx [expr {$x + $dx * $i}]
                    set ny [expr {$y + $dy * $i}]

                    if {[string index [lindex $grid $ny] $nx]
                        ne [string index $word $i]} {
                        set found false
                        break
                    }
                }

                if {$found} {
                    # Tăng tất cả lên 1 (để chuyển từ 0-indexed sang 1-indexed)
                    incr x; incr y; incr endX; incr endY
                    return [list [list $x $y] [list $endX $endY]]
                }
            }
        }
    }

    return {}
}

proc wordSearch {grid words} {
    # Tìm vị trí đầu và cuối của từng từ
    set result {}

    foreach word $words {
        dict set result $word [findWord $grid $word]
    }

    return $result
}