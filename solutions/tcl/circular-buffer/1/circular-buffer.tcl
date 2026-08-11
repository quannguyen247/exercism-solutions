oo::class create CircularBuffer {
    variable capacity buffer

    # Hàm khởi tạo
    constructor {cap} {
        set capacity $cap
        set buffer {}
    }

    # Kiểm tra bộ đệm rỗng
    method empty? {} {
        return [expr {[llength $buffer] == 0}]
    }

    # Kiểm tra bộ đệm đầy
    method full? {} {
        return [expr {[llength $buffer] == $capacity}]
    }

    # Đọc dữ liệu (Lấy phần tử cũ nhất ở đầu mảng)
    method read {} {
        if {[my empty?]} {
            error "buffer is empty"
        }
        set val [lindex $buffer 0]
        set buffer [lrange $buffer 1 end]
        return $val
    }

    # Ghi dữ liệu mới vào cuối
    method write {value} {
        if {[my full?]} {
            error "buffer is full"
        }
        lappend buffer $value
    }

    # Ghi đè (Nếu đầy thì xóa phần tử cũ nhất ở đầu)
    method overwrite {value} {
        if {[my full?]} {
            set buffer [lrange $buffer 1 end]
        }
        lappend buffer $value
    }

    # Reset bộ đệm về rỗng
    method clear {} {
        set buffer {}
    }
}