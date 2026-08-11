namespace eval resistorColor {
    
    # Khai báo danh sách 10 màu theo đúng thứ tự
    variable colorList {black brown red orange yellow green blue violet grey white}

    # Hàm 1: Đổi {args} thành {color}, tìm màu và văng lỗi nếu màu bậy bạ
    proc colorCode {color} {
        variable colorList
        
        set index [lsearch -exact $colorList $color]
        
        if {$index == -1} {
            error "Invalid color: $color"
        }
        
        return $index
    }

    # Hàm 2: Đổi {args} thành {}, chỉ việc trả về nguyên cái list
    proc colors {} {
        variable colorList
        
        return $colorList
    }
}