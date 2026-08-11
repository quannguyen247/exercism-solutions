namespace eval ::resistorColor {

    variable COLOR_MAP [dict create \
        black  0 \
        brown  1 \
        red    2 \
        orange 3 \
        yellow 4 \
        green  5 \
        blue   6 \
        violet 7 \
        grey   8 \
        white  9]

    proc value {color1 color2 args} {
    variable COLOR_MAP

    if {![dict exists $COLOR_MAP $color1]} {
        error "Invalid color"
    }

    if {![dict exists $COLOR_MAP $color2]} {
        error "Invalid color"
    }

    return [expr {
        [dict get $COLOR_MAP $color1] * 10 +
        [dict get $COLOR_MAP $color2]
    }]
}
}