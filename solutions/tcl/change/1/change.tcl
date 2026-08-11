proc findMinimumCoins {target coins} {
    if {$target < 0} {
        error "target can't be negative"
    }
    if {$target == 0} {
        return {}
    }

    # best[số tiền] là cách đổi với ít coin nhất
    array set best {0 {}}

    for {set value 1} {$value <= $target} {incr value} {
        foreach coin $coins {
            # Bỏ qua coin lớn hơn số tiền đang xét
            if {$coin > $value || ![info exists best([expr {$value - $coin}])]} {
                continue
            }

            set candidate [lsort -integer \
                [concat $best([expr {$value - $coin}]) $coin]]

            # Chỉ giữ cách dùng ít coin hơn
            if {![info exists best($value)]
                || [llength $candidate] < [llength $best($value)]} {
                set best($value) $candidate
            }
        }
    }

    # Không có tổ hợp coin nào đúng target
    if {![info exists best($target)]} {
        error "can't make target with given coins"
    }

    return $best($target)
}