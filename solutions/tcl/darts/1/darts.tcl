proc score {x y} {
    # Tính khoảng cách r từ điểm (x,y) tới tâm (0,0)
    set r [expr {hypot($x, $y)}]
    if {$r > 10} {
        return 0
    } elseif {$r > 5} {
        return 1
    } elseif {$r > 1} {
        return 5
    } else {
        return 10
    }
}
