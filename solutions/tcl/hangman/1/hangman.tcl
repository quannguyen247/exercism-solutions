# Get the word from command line
set ::secretWord [split [string tolower [lindex $argv 0]] ""]
set ::maskedWord [lrepeat [llength $::secretWord] "_"]
set ::remainingGuesses 9
set ::status ongoing
set ::serverStatus running

proc newClient {sock addr port} {
    fconfigure $sock -buffering line
    fileevent $sock readable [list handleClient $sock]
}

proc handleClient {sock} {
    if {[eof $sock]} {
        close $sock
        return
    }

    gets $sock line
    set cmd [string tolower [lindex $line 0]]

    switch -- $cmd {
        status {
            # Nothing to update
        }

        guess {
            if {$::status eq "ongoing"} {
                set guess [string tolower [lindex $line 1]]
                set hit 0

                for {set i 0} {$i < [llength $::secretWord]} {incr i} {
                    if {[lindex $::secretWord $i] eq $guess &&
                        [lindex $::maskedWord $i] eq "_"} {

                        lset ::maskedWord $i [string toupper $guess]
                        set hit 1
                    }
                }

                if {!$hit} {
                    incr ::remainingGuesses -1
                }

                if {[lsearch $::maskedWord "_"] == -1} {
                    set ::status win
                } elseif {$::remainingGuesses == 0} {
                    set ::status lose
                }
            }
        }

        shutdown {
            set ::serverStatus finished
            close $sock
            return
        }
    }

    puts $sock [list \
        $::remainingGuesses \
        [join $::maskedWord ""] \
        $::status]
    flush $sock

    if {$::status ne "ongoing"} {
        set ::serverStatus finished
    }
}

# For starting the server, use a proc like this:
#
proc startServer {} {
    # use port 0 to allow Tcl to find an unused port
    set s [socket -server newClient 0]

    # communicate the port number in use
    set sockInfo [chan configure $s -sockname]
    set ::env(HANGMAN_PORT) [lindex $sockInfo 2]
    puts "server started on port $::env(HANGMAN_PORT)"

    # enter the event loop
    vwait ::serverStatus

    close $s
}

# get the word from the $argv list, then:
startServer
