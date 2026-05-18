function pkg --description 'Package utilities'

    # Formatting options for `expac -S`
    #
    # %o optional deps (no descriptions)
    # %p packager name
    # %P provides
    # %R replaces (no version strings)
    # %r repo
    # %s md5sum
    # %S provides (no version strings)
    # %T replaces
    # %u project URL
    # %V package validation method
    # %v version
    # %w install reason (only with -Q)
    # %! result number (auto-incremented counter, starts at 0)
    # %% literal %

    switch $argv[1]
        case info
            set -l pkg $argv[2]
            # Fetch basic info (name, version, repo, description, URL)
            set -l base_info (expac -S -l "\n" "%n
%v
%r
%d
%u" $pkg 2>/dev/null)

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

            # Download size (in MiB)
            set -l size (expac -1 -S -H M '%k' $pkg 2>/dev/null | string trim)
            test -z "$size"; and set size "???"

            # Dependencies
            set -l deps (expac -1 -S '%D' $pkg 2>/dev/null | string split ' ')
            # Optional deps (name: description)
            set -l opt_deps (expac -1 -S '%o' $pkg 2>/dev/null | string split ' ')

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
                for d in $deps
                    if test -z "$d"
                        continue
                    end
                    printf "- %s\n" $d
                end
            end

            # Optional dependencies
            if test (count $opt_deps) -gt 0 -a "$opt_deps" != ""
                echo
                set_color brwhite
                echo "  Optional Dependencies:"
                set_color normal
                for o in $opt_deps
                    if test -z "$o"
                        continue
                    end
                    set -l parts (string split ':' $o)
                    if test (count $parts) -ge 2
                        printf "- %-20s %s\n" $parts[1] $parts[2]
                    else
                        printf "- %s\n" $parts[1]
                    end
                end
            end
            echo
        case deps
            # List the dependencies of a package
            expac -1 -S '%D' $argv[2..-1]
        case optional
            # List the optional dependencies of a package
            expac -1 -S "%o" $argv[2..-1]
        case size
            # List the download size of packages in MiB
            expac -1 -S -H M '%k\t%n' $argv[2..-1]
        case updates
            # List updateable packages with download size
            expac -1 -S -H M '%n\t%k' $(paru -Qqu) | sort -sh | column --table --table-column name=Package,color=gray --table-column Size,right --separator \t
        case uppdate-system
            # Update the system
            paru -Syu --newsonupgrade --removemake
        case update-aur
            # Update the AUR
            paru -Sau --newsonupgrade --removemake

        case '*'
            pkg info $argv
    end
end

complete --command pkg --no-files
complete -c pkg -f -n "not __fish_seen_subcommand_from info deps optional size updates" \
    -a "info\t'Show information about a package' \
        deps\t'List dependencies of a package' \
        optional\t'List optional dependencies of a package' \
        size\t'Show download size of packages in MiB' \
        updates\t'List packages marked for upgrade with sizes'
        uppdate-system\t'Update the system'
        update-aur\t'Update the AUR'"

# For `deps`, `optional` and `size`, complete with available package names
for sub in info deps optional size
    complete -c pkg -f -n "__fish_seen_subcommand_from $sub" \
        -a "(__fish_print_packages)"
end
