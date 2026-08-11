proc parse_inline {line} {
    # Biến đổi In Đậm: __bold__ -> <strong>bold</strong>
    set line [regsub -all {__(.*?)__} $line {<strong>\1</strong>}]
    
    # Biến đổi In Nghiêng: _italic_ -> <em>italic</em>
    set line [regsub -all {_(.*?)_} $line {<em>\1</em>}]
    
    return $line
}

proc parse {markdownText} {
    set html ""
    set in_list false

    # Duyệt qua từng dòng văn bản
    foreach line [split $markdownText "\n"] {
        # Bước 1: Xử lý các định dạng in đậm/in nghiêng trước
        set line [parse_inline $line]

        # Bước 2: Phân loại cấu trúc Khối (Block Structure) bằng Pattern Matching
        
        # TH1: Thẻ Tiêu đề (# Header, ## Header...)
        if {[regexp {^(#{1,6})\s+(.*)} $line -> hashes title]} {
            if {$in_list} {
                append html "</ul>"
                set in_list false
            }
            set level [string length $hashes]
            append html "<h$level>$title</h$level>"

        # TH2: Thẻ Danh sách (* Item)
        } elseif {[regexp {^\*\s+(.*)} $line -> item]} {
            if {!$in_list} {
                append html "<ul>"
                set in_list true
            }
            append html "<li>$item</li>"

        # TH3: Thẻ Đoạn văn bình thường (Paragraph)
        } else {
            if {$in_list} {
                append html "</ul>"
                set in_list false
            }
            append html "<p>$line</p>"
        }
    }

    # Đóng thẻ </ul> nếu dòng cuối cùng là một phần tử trong danh sách
    if {$in_list} {
        append html "</ul>"
    }

    return $html
}
