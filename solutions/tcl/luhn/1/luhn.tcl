proc luhn {digits} {
    # Xóa sạch khoảng trắng
    set cleaned_digits [string map {" " ""} $digits]

    # Kiểm tra độ dài <= 1 hoặc chứa ký tự không phải số (0-9)
    if {[string length $cleaned_digits] <= 1 || ![regexp {^[0-9]+$} $cleaned_digits]} {
        return false
    }

    # Đảo ngược chuỗi để duyệt từ phải sang trái từ index 0
    set rev [string reverse $cleaned_digits]
    set sum 0

    # Duyệt qua từng chữ số
    for {set i 0} {$i < [string length $rev]} {incr i} {
        set d [string index $rev $i]

        # Vị trí i lẻ (tương ứng với chữ số thứ 2, 4, 6... từ phải sang)
        if {$i % 2 == 1} {
            set d [expr {$d * 2}]
            if {$d > 9} {
                set d [expr {$d - 9}]
            }
        }

        incr sum $d
    }

    # Kiểm tra tổng chia hết cho 10
    return [expr {$sum % 10 == 0}]
}
