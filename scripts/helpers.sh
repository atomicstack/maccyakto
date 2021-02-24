#!/bin/bash

get_tmux_option() {
    local option default_value option_value

    option=$1
    default_value=$2
    option_value=$(tmux show-option -gqv "$option")

    if [[ -z "$option_value" ]]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

get_option() {
    local option=$1

    case "$option" in
        "@maccyakto_key")
            echo $(get_tmux_option $option "tab")
            ;;

        "@maccyakto_split_direction")
            echo $(get_tmux_option $option "a")
            ;;

        "@maccyakto_split_size")
            echo $(get_tmux_option $option "7")
            ;;

        "@maccyakto_grab_area")
            echo $(get_tmux_option $option "full")
            ;;

        "@maccyakto_clip_tool")
            echo $(get_tmux_option $option "auto")
            ;;

        "@maccyakto_fzf_tool")
            echo $(get_tmux_option $option "fzf")
            ;;

        "@maccyakto_open_tool")
            echo $(get_tmux_option $option "auto")
            ;;

        "@maccyakto_copy_key")
            echo $(get_tmux_option $option "enter")
            ;;

        "@maccyakto_insert_key")
            echo $(get_tmux_option $option "tab")
            ;;

        "@maccyakto_filter_key")
            echo $(get_tmux_option $option "ctrl-f")
            ;;

        "@maccyakto_open_key")
            echo $(get_tmux_option $option "ctrl-o")
            ;;

        "@maccyakto_edit_key")
            echo $(get_tmux_option $option "ctrl-e")
            ;;

        "@maccyakto_grab_key")
            echo $(get_tmux_option $option "ctrl-g")
            ;;

        "@maccyakto_help_key")
            echo $(get_tmux_option $option "ctrl-h")
            ;;

        "@maccyakto_clip_tool_run")
            echo $(get_tmux_option $option "bg")
            ;;

        "@maccyakto_popup_size")
            echo $(get_tmux_option $option "90%")
            ;;

        "@maccyakto_popup_position")
            echo $(get_tmux_option $option "C")
            ;;

        "@maccyakto_fzf_layout")
            echo $(get_tmux_option $option "default")
            ;;

    esac
}

# This returns the start point parameter for `tmux capture-pane`.
# The result will depend on how the user has set the grab area and grab size.
get_capture_pane_start() {
    local grab_area capture_start history_limit

    grab_area="$1"

    if [[ "$grab_area" == "recent" || "$grab_area" == "window recent" ]]; then
        capture_start="-10"

    elif [[ "$grab_area" == "full" || "$grab_area" == "window full" ]]; then
        # use the history limit, this is all the data on the pane
        # if not set just go with tmux's default
        history_limit=$(get_tmux_option "history-limit" "2000")
        capture_start="-${history_limit}"

    elif [[ "$grab_area" =~ ^window\  ]]; then
        # use the user defined limit for how much to grab from every pane in the current window
        capture_start="-${grab_area:7}"

    else
        # use the user defined limit for how much to grab from the current pane
        capture_start="-${grab_area}"
    fi

    echo "$capture_start"
}
