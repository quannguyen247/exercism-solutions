proc raindrops {number} {
    set result ""

    # Thêm âm thanh nếu số chia hết
    foreach {factor sound} {3 Pling 5 Plang 7 Plong} {
        if {$number % $factor == 0} {
            append result $sound
        }
    }

    # Không có âm thanh thì trả lại số
    if {$result eq ""} {
        return $number
    }

    return $result
}
