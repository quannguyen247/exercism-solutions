proc tripletsWithSum {perimeter} {
    set result {}

    # Từ a và chu vi, suy ra b rồi tính c
    for {set a 1} {$a < $perimeter / 3} {incr a} {
        set numerator [expr {$perimeter * ($perimeter - 2 * $a)}]
        set denominator [expr {2 * ($perimeter - $a)}]

        if {$numerator % $denominator} {
            continue
        }

        set b [expr {$numerator / $denominator}]
        set c [expr {$perimeter - $a - $b}]

        # Chỉ nhận bộ có thứ tự a < b < c
        if {$a < $b && $b < $c} {
            lappend result [list $a $b $c]
        }
    }

    return $result
}
