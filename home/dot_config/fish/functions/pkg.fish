function pkg --description 'Package utilities'
    set -l CACHE_FILE "/tmp/pkg-sizes.cache"
    set -l CACHE_TTL (math "60 * 30") # 30 minutes

    # Formatting options for `--print-format` (pacman, yay, paru)
    # "%a" for arch
    # "%b" for builddate
    # "%d" for description
    # "%e" for pkgbase
    # "%f" for filename
    # "%g" for base64 encoded PGP signature
    # "%h" for sha256sum
    # "%m" for md5sum
    # "%n" for pkgname
    # "%p" for packager
    # "%v" for pkgver
    # "%l" for location
    # "%r" for repository
    # "%s" for size
    # "%C" for checkdepends
    # "%D" for depends
    # "%G" for groups
    # "%H" for conflicts
    # "%L" for licenses
    # "%M" for makedepends
    # "%O" for optional depends
    # "%P" for provides and "%R" for replaces.
    switch $argv[1]
        # clear or clean => clear cache
        case clean clear
            rm $CACHE_FILE 2>/dev/null
            echo "Cache cleared."
        case info
            set -l pkg $argv[2]
            # Fetch basic info (name, version, repo, description, URL)
            set -l base_info (yay -S --print-format "%n
%v
%r
%d
%u
%s
%D
%O
" $pkg 2>/dev/null)

            if test $status -ne 0 -o -z "$base_info"
                set_color red
                echo "Package '$pkg' not found."
                set_color normal
                return 1
            end

            set -l name $base_info[1]
            set -l ver $base_info[2]
            set -l repo $base_info[3]
            set -l desc $base_info[4]
            set -l url $base_info[5]
            set -l size $base_info[6]
            set -l deps $base_info[7]
            set -l opt_deps $base_info[8]

            # Download size (in MiB)
            test -z "$size"; and set size "???"

            # Dependencies

            # --- Output ---
            set_color brwhite
            echo "╔═══════════════════════════════════════════════╗"
            echo "║ Package Information                           ║"
            echo "╚═══════════════════════════════════════════════╝"
            set_color normal

            printf "%-14s " "Package:"
            set_color brwhite
            echo $name
            set_color normal

            if test -n "$desc" -a "$desc" != None
                printf "%-14s " "Description:"
                set_color white
                echo $desc
                set_color normal
            end

            printf "%-14s " "Version:"
            set_color yellow
            echo $ver
            set_color normal

            printf "%-14s " "Repository:"
            set_color brgreen
            echo $repo
            set_color normal

            printf "%-14s " "Size:"
            set_color blue
            echo "$size MiB"
            set_color normal

            if test -n "$url" -a "$url" != None
                printf "%-14s " "URL:"
                set_color brblue
                echo $url
                set_color normal
            end

            # Dependencies
            if test (count $deps) -gt 0 -a "$deps" != ""
                echo ""
                set_color bryellow
                echo "Dependencies:"
                set_color normal
                for d in $(string split " " $deps | uniq)
                    if test -z "$d"
                        continue
                    end
                    printf "- %s\n" $d
                end
            end

            if test (count $opt_deps) -gt 0 -a "$opt_deps" != ""
                echo
                set_color brwhite
                echo "Optional Dependencies:"
                set_color normal

                for dep in $(string replace ':' '' $(string split ": " $(string match --all -r '(\w+):' $opt_deps)) | uniq)
                    printf "- %s\n" $dep
                end
            end
        case deps
            # List the dependencies of a  package
            expac -1 -S '%D' $argv[2..-1]
        case optional
            # List the optional dependencies of a package
            expac -1 -S "%o" $argv[2..-1]
        case updates sizes
            set -l CACHED 0

            set -l packages

            echo "Fetching..."
            set packages $(yay -Su --print-format "%s %n (%r)" | sort -h)
            set CACHED 0

            printf '%s\n' $packages | sort -h >$CACHE_FILE

            # Build and display results
            set -l total_bytes 0
            set -l pkg_count 0
            set -l processed

            for line in $packages
                set -l size (echo $line | awk '{print $1}')
                set -l name (echo $line | awk '{print $2}')
                set -l repo (echo $line | awk '{print $3}' | tr -d '()')

                if test -n "$size"; and test -n "$name"
                    set total_bytes (math "$total_bytes + $size")
                    set pkg_count (math "$pkg_count + 1")
                    set size_human (numfmt --to=iec --suffix=B $size)
                    set processed $processed "$size_human|$name|$repo"
                end
            end

            # Cache the results
            printf '%s\n' $processed | sort -h | column -s "|" --table --table-column "name=Size,color=green,right" --table-column "name=Package,color=white" --table-column "name=Repo,color=grey"
            # Summary with color
            set -l total_human (numfmt --to=iec --suffix=B --format="%.1f" $total_bytes)
            echo

            echo "$(set_color red)==> $(set_color red)$total_human$(set_color normal)"
            echo "$(set_color yellow)==> $pkg_count packages$(set_color normal)"
            if test $CACHED -eq 1
                set -l cache_time (date -r $CACHE_FILE +%s)
                set -l now (date +%s)
                set -l diff (math $now - $cache_time)
                set -l minutes (math "round($diff / 60)")

                echo "$(set_color blue)==> Cached $minutes minutes ago"
            else
                echo "$(set_color blue)==> Fetched just now"
            end
        case uppdate-system
            # Update the system
            paru -Syu --newsonupgrade --removemake
        case update-aur
            # Update the AUR
            paru -Sau --newsonupgrade --removemake

        case '*' # Fallback
            echo "Unknown subcommand: $argv[1]" >&2
            echo "Usage: pkg [info|deps|optional|sizes|updates|uppdate-system|update-aur|clear] <package-name>" >&2
            return 1
    end
end

complete --command pkg --no-files
complete -c pkg -f -n "not __fish_seen_subcommand_from info deps optional size updates" \
    -a "info\t'Show information about a package' \
        deps\t'List dependencies of a package' \
        optional\t'List optional dependencies of a package' \
        updates\t'List packages marked for upgrade with sizes'
        uppdate-system\t'Update the system'
        update-aur\t'Update the AUR'
        clear\t'Clear the cache'"

# For `deps`, `optional` and `size`, complete with available package names
for sub in info deps optional size updates
    complete -c pkg -f -n "__fish_seen_subcommand_from $sub" \
        -a "(__fish_print_packages)"
end
