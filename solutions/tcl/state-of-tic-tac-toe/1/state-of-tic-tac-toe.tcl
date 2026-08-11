proc gamestate {board} {
    set cells [join $board ""]
    set x [regexp -all X $cells]
    set o [regexp -all O $cells]

    # X luôn đi trước O
    if {$x > $o + 1} {
        error "Wrong turn order: X went twice"
    }
    if {$o > $x} {
        error "Wrong turn order: O started"
    }

    # Gom hàng, cột và hai đường chéo
    set lines [concat $board [list \
        "[string index [lindex $board 0] 0][string index [lindex $board 1] 0][string index [lindex $board 2] 0]" \
        "[string index [lindex $board 0] 1][string index [lindex $board 1] 1][string index [lindex $board 2] 1]" \
        "[string index [lindex $board 0] 2][string index [lindex $board 1] 2][string index [lindex $board 2] 2]" \
        "[string index [lindex $board 0] 0][string index [lindex $board 1] 1][string index [lindex $board 2] 2]" \
        "[string index [lindex $board 0] 2][string index [lindex $board 1] 1][string index [lindex $board 2] 0]"]]

    set xWon [expr {"XXX" in $lines}]
    set oWon [expr {"OOO" in $lines}]

    # Người thắng phải đúng lượt vừa đi
    if {$xWon && !$oWon && $x == $o + 1 || $oWon && !$xWon && $x == $o} {
        return win
    }
    
    if {$xWon || $oWon} {
        error "Impossible board: game should have ended after the game was won"
    }

    return [expr {[string first " " $cells] < 0 ? "draw" : "ongoing"}]
}
