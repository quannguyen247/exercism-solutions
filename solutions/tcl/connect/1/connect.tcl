proc hasPath {grid player vertical} {
    set height [llength $grid]
    set width [llength [lindex $grid 0]]
    set stack {}

    # Lấy các quân ở cạnh bắt đầu
    set count [expr {$vertical ? $width : $height}]
    for {set i 0} {$i < $count} {incr i} {
        set x [expr {$vertical ? $i : 0}]
        set y [expr {$vertical ? 0 : $i}]
        if {[lindex $grid $y $x] eq $player} {
            lappend stack [list $x $y]
        }
    }

    set seen {}
    while {$stack ne {}} {
        set point [lindex $stack end]
        set stack [lrange $stack 0 end-1]
        if {[dict exists $seen $point]} {continue}

        dict set seen $point 1
        lassign $point x y

        if {($vertical && $y == $height - 1)
            || (!$vertical && $x == $width - 1)} {
            return true
        }

        # Kiểm tra 6 ô kề trên bàn cờ lục giác
        foreach {dx dy} {0 -1 1 -1 -1 0 1 0 -1 1 0 1} {
            set nx [expr {$x + $dx}]
            set ny [expr {$y + $dy}]

            if {$nx >= 0 && $nx < $width
                && $ny >= 0 && $ny < $height
                && [lindex $grid $ny $nx] eq $player} {
                lappend stack [list $nx $ny]
            }
        }
    }
    return false
}

proc winner {board} {
    set grid {}

    # Bỏ khoảng trắng để tạo bàn cờ
    foreach row $board {
        lappend grid [split [string map {" " ""} $row] ""]
    }

    if {[hasPath $grid O true]} {return O}
    if {[hasPath $grid X false]} {return X}
    return ""
}