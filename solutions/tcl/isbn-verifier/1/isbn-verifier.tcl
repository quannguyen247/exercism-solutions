proc isValid {isbn} {
    # Xóa tất cả dấu gạch ngang '-'
    set clean [string map {- ""} $isbn]
    
    # Kiểm tra định dạng: Bắt buộc đúng 9 chữ số (0-9) + 1 chữ số cuối (0-9 hoặc X)
    if {![regexp {^[0-9]{9}[0-9X]$} $clean]} {
        return false
    }
    
    # Tính tổng tích d1*10 + d2*9 + ... + d10*1
    set sum 0
    for {set i 0} {$i < 10} {incr i} {
        set char [string index $clean $i]
        set val [expr {$char eq "X" ? 10 : $char}]
        set sum [expr {$sum + $val * (10 - $i)}]
    }
    
    # Trả về true nếu tổng chia hết cho 11
    return [expr {$sum % 11 == 0}]
}