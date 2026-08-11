proc maximumValue {maxWeight items} {
    # best[w] là giá trị lớn nhất với sức chứa w
    set best [lrepeat [expr {$maxWeight + 1}] 0]

    foreach item $items {
        dict with item {}

        # Duyệt ngược để mỗi món chỉ được lấy một lần
        for {set w $maxWeight} {$w >= $weight} {incr w -1} {
            set total [expr {[lindex $best [expr {$w - $weight}]] + $value}]
            if {$total > [lindex $best $w]} {
                lset best $w $total
            }
        }
    }

    return [lindex $best end]
}