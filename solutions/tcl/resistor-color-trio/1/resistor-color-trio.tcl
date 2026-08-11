namespace eval ::resistorColor {
    proc label {args} {
        set colors {
            black brown red orange yellow
            green blue violet grey white
        }

        # Đổi ba màu đầu thành ba chữ số
        set digits [lmap color [lrange $args 0 2] {
            lsearch -exact $colors $color
        }]

        lassign $digits first second zeros
        set value [expr {
            ($first * 10 + $second) * 10 ** $zeros
        }]

        # Rút gọn theo từng nhóm 1000
        set units {ohms kiloohms megaohms gigaohms}
        set unit 0

        while {$value >= 1000 && $value % 1000 == 0} {
            set value [expr {$value / 1000}]
            incr unit
        }

        return "$value [lindex $units $unit]"
    }
}
