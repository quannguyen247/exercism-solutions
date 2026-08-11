proc steps {number} {
    # Kiểm tra điều kiện đầu vào phải là số nguyên dương > 0
    if {$number <= 0} {
        error "Only positive integers are allowed"
    }

    # Lặp cho đến khi number biến đổi về 1
    set count 0
    while {$number > 1} {
        incr count
        if {$number % 2 == 0} {
            set number [expr {$number / 2}]
        } else {
            set number [expr {$number * 3 + 1}]
        }
    }

    return $count
}
