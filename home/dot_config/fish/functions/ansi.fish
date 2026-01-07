function ansi --description "Show control character information"
    set -l start_byte
    set -l end_byte
    set -l is_range false

    # Parse range syntax (e.g., "0x40..0x2F" or "64..47")
    if string match -qr '\.\.' -- $argv[1]
        set is_range true
        set -l range_parts (string split '..' -- $argv[1])

        # Convert hex or decimal to decimal
        if string match -qr '^0x' -- $range_parts[1]
            set start_byte (printf "%d" $range_parts[1])
        else
            set start_byte $range_parts[1]
        end

        if string match -qr '^0x' -- $range_parts[2]
            set end_byte (printf "%d" $range_parts[2])
        else
            set end_byte $range_parts[2]
        end
    # Original two-argument syntax
    else if test (count $argv) -ge 2
        set is_range true
        set start_byte $argv[1]
        set end_byte $argv[2]
    # Single value
    else
        set start_byte $argv[1]
        set end_byte $argv[1]
    end

    echo $start_byte $end_byte

    if test $is_range = false
        printf "\x$(printf %x $start_byte)" | od -A n -t a | string trim
    else
        set -l characters
        set -l rows

        for byte in (seq $start_byte $end_byte)
            set -l character (string escape (printf "\x$(printf %x $byte)" | od -A n -t a | string trim))
            set -l hexadecimal (printf "0x%02x" $byte)
            set -l decimal (printf "%d" $byte)

            set -a characters $character
            set -a rows (echo -e "$character\t$hexadecimal\t$decimal")
        end

        echo -e "$characters\n"

        printf "%s\n" $rows | column -t -o " | " -S 1 --table-columns "Character,Hex,Byte" --table-name "$start_byte..$end_byte"
    end
end
