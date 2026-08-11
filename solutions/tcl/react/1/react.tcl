oo::class create InputCell {
    variable value

    constructor {val} {
        # Khởi tạo giá trị ban đầu cho ô input
        set value $val
    }

    method setValue {aValue} {
        # Cập nhật giá trị mới cho ô input
        set value $aValue
    }

    method value {} {
        # Trả về giá trị hiện tại
        return $value
    }
}

oo::class create ComputeCell {
    variable dependentCells computeFunction

    constructor {cells func} {
        # For more details about what a "func" is,
        # see the documentation for the [apply] command:
        # https://tcl.tk/man/tcl8.6/TclCmd/apply.htm
        
        # Lưu trữ danh sách các ô phụ thuộc và hàm tính toán
        set dependentCells $cells
        set computeFunction $func
    }

    method value {} {
        # Lấy giá trị của từng ô phụ thuộc và áp dụng hàm tính toán
        apply $computeFunction [lmap cell $dependentCells {$cell value}]
    }

    method addCallback {func} {
        # Khởi tạo một đối tượng Callback theo dõi chính ô ComputeCell này ([self])
        Callback new $func [self]
    }

    method removeCallback {callback} {
        # Vô hiệu hóa callback được truyền vào
        $callback disable
    }
}

oo::class create Callback {
    variable callbackFunc targetCell previousValue lastReportedValue isActive

    constructor {args} {
        # Lấy hàm callback và ô cần theo dõi từ đối số truyền vào
        lassign $args func cell
        set callbackFunc $func
        set targetCell $cell
        
        # Lưu lại giá trị tính toán ban đầu làm mốc so sánh
        set previousValue [apply $callbackFunc $targetCell]
        set lastReportedValue {}
        
        # Đánh dấu trạng thái callback đang hoạt động
        set isActive 1
    }

    method value {} {
        # Nếu callback đã bị gỡ bỏ, trả về giá trị báo cáo gần nhất của nó
        if {!$isActive} {
            return $lastReportedValue
        }
        
        # Tính toán giá trị mới nhất tại thời điểm hiện tại
        set currentValue [apply $callbackFunc $targetCell]
        
        # Chỉ trả về giá trị nếu có sự thay đổi so với mốc trước đó
        if {$currentValue ne $previousValue} {
            set previousValue $currentValue
            set lastReportedValue $currentValue
            return $currentValue
        }
    }

    # Phương thức vô hiệu hóa callback sạch sẽ
    method disable {} {
        set isActive 0
    }
}
