proc plants {diagram student} {
    # Dict ánh xạ tên học sinh sang vị trí k
    set student_dict {
        Alice 0 Bob 1 Charlie 2 David 3
        Eve 4 Fred 5 Ginny 6 Harriet 7
        Ileana 8 Joseph 9 Kincaid 10 Larry 11
    }

    # Dict ánh xạ mã cây sang tên đầy đủ
    set plant_names {
        G grass C clover R radishes V violets
    }

    # Lấy vị trí k của học sinh
    set k [dict get $student_dict $student]

    # Tách 2 hàng cây
    lassign [split $diagram "\n"] row1 row2

    # Tính 2 vị trí index i1 và i2 
    set i1 [expr {$k * 2}]
    set i2 [expr {$k * 2 + 1}]
    
    # Cắt 2 ký tự row1 + 2 ký tự row2 rồi phân ra từng chữ cái
    set codes [split "[string range $row1 $i1 $i2][string range $row2 $i1 $i2]" ""]
    
    # Dùng lmap dịch toàn bộ mã chữ cái thành tên cây
    return [lmap c $codes {dict get $plant_names $c}]
}
