proc bracketsMatch {input} {
    # Các dấu cùng vị trí là một cặp
    set opens "\(\[\{"
    set closes "\)\]\}"
    set stack {}

    foreach char [split $input ""] {
        set index [string first $char $opens]

        # Gặp dấu mở ngoặc thì thêm vào stack
        if {$index >= 0} {
            lappend stack $char
            continue
        }

        set index [string first $char $closes]

        # Bỏ qua ký tự không phải dấu ngoặc
        if {$index < 0} {
            continue
        }

        # So sánh với dấu mở ngoặc cuối stack
        set lastOpen [lindex $stack end]
        set expectedOpen [string index $opens $index]

        if {$stack eq {} || $lastOpen ne $expectedOpen} {
            return false
        }

        # Xóa dấu mở ngoặc đã ghép cặp
        set stack [lrange $stack 0 end-1]
    }

    # Stack rỗng = mọi dấu ngoặc đã được ghép cặp
    return [expr {$stack eq {}}]
}