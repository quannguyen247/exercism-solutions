oo::class create PlatformIO {
    # Your class must contain these methods
    #
    # open   -- to wrap file channels for monitoring file i/o
    # socket -- to wrap network sockets for monitoring network i/o
    # stats  -- to return the statistics as a dictionary
    #
    # Your class instances must also conform to the 
    # channel transform command handler API
    # https://www.tcl-lang.org/man/tcl9.0/TclCmd/transchan.html

    variable counts

    # Đặt các số liệu ban đầu về 0
    constructor {} {
        set counts [dict create reads 0 readBytes 0 writes 0 writeBytes 0]
    }

    # Mở file và bắt đầu theo dõi
    method open {args} {
        set channel [::open {*}$args]
        ::chan push $channel [self]
        return $channel
    }

    # Mở kết nối mạng và bắt đầu theo dõi
    method socket {args} {
        set channel [::socket {*}$args]
        ::chan push $channel [self]
        return $channel
    }

    # Lấy các số liệu đã đếm
    method stats {} {
        return $counts
    }

    # Khởi tạo thao tác đọc và ghi
    method initialize {handle mode} {
        return [list initialize finalize {*}$mode]
    }

    # Không cần xử lý thêm khi đóng channel
    method finalize {handle} {}

    # Cộng số lần đọc và số byte đọc
    method read {handle data} {
        dict incr counts reads
        dict incr counts readBytes [string length $data]
        return $data
    }

    # Cộng số lần ghi và số byte ghi
    method write {handle data} {
        dict incr counts writes
        dict incr counts writeBytes [string length $data]
        return $data
    }
}
