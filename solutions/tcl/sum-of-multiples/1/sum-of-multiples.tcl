proc sumOfMultiples {factors limit} {
    set total 0

    # Chạy từng số từ 1 đến limit - 1
    for {set i 1} {$i < $limit} {incr i} {
        # Thử xem số i có chia hết cho bất kỳ hệ số nào trong list $factors không
        foreach f $factors {
            if {$f > 0 && $i % $f == 0} {
                incr total $i
                break
            }
        }
    }

    return $total
}