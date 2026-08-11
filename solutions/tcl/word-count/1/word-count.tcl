proc countWords {sentence} {
    set counts {}

    # Lấy chữ, số và dấu nháy đơn nằm giữa một từ
    foreach word [regexp -all -inline {[[:alnum:]]+(?:'[[:alnum:]]+)*} \
        [string tolower $sentence]] {
        dict incr counts $word
    }

    return $counts
}