proc rotate {text shift} {
    set shift [expr {$shift % 26}]
    set mapping {}

    foreach alphabet {
        abcdefghijklmnopqrstuvwxyz
        ABCDEFGHIJKLMNOPQRSTUVWXYZ
    } {
        # Nối bảng chữ cái hai lần để dịch vòng
        set rotated [string range "$alphabet$alphabet" \
            $shift [expr {$shift + 25}]]

        # Ghép từng chữ cũ với chữ mới
        foreach old [split $alphabet ""] new [split $rotated ""] {
            lappend mapping $old $new
        }
    }

    # Số, khoảng trắng và dấu câu được giữ nguyên
    return [string map $mapping $text]
}