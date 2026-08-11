namespace eval ::resistorColor {
    # Vị trí của màu trong list chính là giá trị
    variable colors {
        black brown red orange yellow
        green blue violet grey white
    }

    proc value {first second args} {
        variable colors

        # Chỉ lấy giá trị của hai màu đầu
        set firstValue [lsearch -exact $colors $first]
        set secondValue [lsearch -exact $colors $second]

        if {$firstValue < 0 || $secondValue < 0} {
            error "Invalid color"
        }

        # Ghép hai giá trị thành một số
        return [expr {$firstValue * 10 + $secondValue}]
    }
}