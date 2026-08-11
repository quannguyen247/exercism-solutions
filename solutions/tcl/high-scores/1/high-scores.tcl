#! tclsh

oo::class create HighScores {
    variable history

    constructor {} {
        set history {}
    }

    method addScores {args} {
        # Thêm điểm mới, giữ nguyên thứ tự
        lappend history {*}$args
    }

    method scores {} {
        return $history
    }

    method latest {} {
        return [lindex $history end]
    }

    method personalBest {} {
        return [lindex [lsort -integer $history] end]
    }

    method topThree {} {
        # Sắp xếp giảm dần rồi lấy tối đa ba điểm
        return [lrange [lsort -integer -decreasing $history] 0 2]
    }
}
