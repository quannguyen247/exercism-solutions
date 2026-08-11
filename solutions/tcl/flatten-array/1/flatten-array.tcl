proc flatten {input} {
    set result {}

    foreach item $input {
        # Bỏ qua giá trị rỗng
        if {$item eq ""} {
            continue
        }

        set size [llength $item]

        # Nếu còn list lồng nhau thì mở tiếp
        if {$size > 1 || ($size == 1 && [lindex $item 0] ne $item)} {
            lappend result {*}[flatten $item]
        } else {
            lappend result $item
        }
    }

    return $result
}