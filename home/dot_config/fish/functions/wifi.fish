function wifi --description "Quickly save and connect to a WiFi network"
    set -l CONFIG "$HOME/.wifi"

    function _wifi_save
        set ssid (nmcli -t -f active,ssid dev wifi | awk -F: '$1=="yes" {print $2}')
        if test -n "$ssid"
            echo "$ssid" >"$CONFIG"
            echo "Saved WiFi: $ssid"
        else
            echo "No WiFi currently connected"
        end
    end

    function _wifi_connect
        set -l max 5

        if test -f "$CONFIG"
            set saved (cat "$CONFIG")
            echo "Attempting to connect to '$saved' ..."

            # Retry 5 times (note: your comment said 3 but loop goes to 5)
            for i in (seq 1 $max)
                if not nmcli -t device wifi connect "$saved" >/dev/null 2>&1
                    echo "Searching... ($i/$max)"
                    sleep 2
                    nmcli device wifi rescan >/dev/null 2>&1
                else
                    echo "Connected."
                    break
                end
            end
        else
            echo "No saved WiFi found"
        end
    end

    # Usage
    switch "$argv[1]"
        case save
            _wifi_save
        case connect
            _wifi_connect
        case "*"
            _wifi_connect
    end
end
