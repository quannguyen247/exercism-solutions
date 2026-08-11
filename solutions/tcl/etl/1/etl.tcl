proc transform {legacy} {
    if {[llength $legacy] % 2 != 0} {
        return -code error "invalid input"
    }
    set result [dict create]
    dict for {score letters} $legacy {
        foreach letter $letters {
            dict set result [string tolower $letter] $score
        }
    }
    return $result
}