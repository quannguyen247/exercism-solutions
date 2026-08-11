proc reverse {input} {
    set res ""
    # Tách chuỗi thành từng chữ cái và duyệt qua
    foreach char [split $input ""] {
        set res "$char$res"
    }
    return $res
}