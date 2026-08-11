proc matrixFrom {inputString} {
    foreach line [split $inputString "\n"] {
        lappend matrix $line
    }
    return $matrix
}
    
proc row {matrix n} {
    return [lindex $matrix $n-1]
}
    
proc column {matrix n} {
    return [lmap x $matrix {lindex $x $n-1}]    
}
