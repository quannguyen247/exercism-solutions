proc verse {num} {
    set items {
        {"house that Jack built." ""}
        {"malt" "that lay in"}
        {"rat" "that ate"}
        {"cat" "that killed"}
        {"dog" "that worried"}
        {"cow with the crumpled horn" "that tossed"}
        {"maiden all forlorn" "that milked"}
        {"man all tattered and torn" "that kissed"}
        {"priest all shaven and shorn" "that married"}
        {"rooster that crowed in the morn" "that woke"}
        {"farmer sowing his corn" "that kept"}
        {"horse and the hound and the horn" "that belonged to"}
    }

    set idx [expr {$num - 1}]
    set lines [list "This is the [lindex $items $idx 0]"]

    for {set i $idx} {$i > 0} {incr i -1} {
        set verb [lindex $items $i 1]
        set prev_noun [lindex $items [expr {$i - 1}] 0]
        lappend lines "$verb the $prev_noun"
    }

    # Nối các câu trong 1 khổ bằng " "
    return [join $lines " "]
}

proc recite {from to} {
    set verses {}
    for {set v $from} {$v <= $to} {incr v} {
        lappend verses [verse $v]
    }
    
    # Nối các khổ thơ bằng "\n"
    return [join $verses "\n"]
}