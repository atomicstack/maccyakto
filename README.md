# maccyakto for tmux

![intro](https://github.com/laktak/maccyakto/wiki/assets/intro1.gif)

**Output completions** - you can complete commands that require you to retype text that is already on the screen. This works everywhere, even in remote ssh sessions.

You can **fuzzy find your text** instead of selecting it by hand:

- press tmux `prefix + tab` to start maccyakto
- fuzzy find the text/path/url/line
- press
  - `tab` to insert it to the current pane,
  - `enter` to copy it to the clipboard,
- see other features in [HELP](HELP.md) (press `ctrl-h` in maccyakto)

Use it for paths, URLs, options from a man page, git hashes, docker container names, ...

## Installation

Requires

- [tmux](https://github.com/tmux/tmux/wiki)
- [fzf](https://github.com/junegunn/fzf)
- Python 3.6+
- Bash (tested with 5.0+, on macOS please `brew install bash` first)

Supported clipboards:

- Linux (xclip)
- macOS (pbcopy)
- WSL (aka "Bash on Windows")
- *bring your own*

### tmux beta

Because tmux with popups will not be released before/around May 2021 you may wish to install the master/beta version.

- On Arch: `trizen -S tmux-git` or `yay -S tmux-git` (see your AUR package manager)
- On macOS with homebrew: `brew install tmux --HEAD`

If you do not wish to install the beta maccyakto will open in a split window.

### a: with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add the plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'laktak/maccyakto'

Hit `prefix + I` to fetch the plugin and source it.

You should now have all `maccyakto` key bindings defined.

### b: Manual Installation

Clone the repo:

    $ git clone https://github.com/laktak/maccyakto ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/maccyakto.tmux

Reload the tmux environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now have all `maccyakto` key bindings defined.

### Wiki

Add or look for special tips in our [wiki](https://github.com/laktak/maccyakto/wiki).

### Options

To set any of these options write on your `~/.tmux.conf` file:

```
set -g <option> "<value>"
```

Where `<option>` and `<value>` are one of the specified here:

| Option                      | Default  | Description |
| :---                        | :---:    | :--- |
| `@maccyakto_key`             | `tab`    | The key binding to start. If you have any special requirements (like a custom key table) set this to 'none' and define a binding in your `.tmux.conf`. See `maccyakto.tmux` for a sample. |
| `@maccyakto_split_direction` | `a`      | Whether the tmux split will be `a`uto, `p`opup, `v`ertical or `h`orizontal |
| `@maccyakto_split_size`      | `7`      | The size of the tmux split (for vertical/horizontal) |
| `@maccyakto_popup_size`      | `90%`    | Set width and height of the tmux popup window. Set this to `w,h` to set the width to `w` and height to `h`. |
| `@maccyakto_popup_position`  | `C`      | Set position of the tmux popup window. Possible values are in the `display-popup` entry in `man tmux`. Set this to `x,y` to set the x and y positions to `x` and `y` respectively. |
| `@maccyakto_grab_area`       | `full`   | Whether you want maccyakto to grab data from the `recent` area, the `full` pane, all current window's `recent` areas or all current window's `full` panes. You can also set this option to any number you want (or number preceded by "window ", e.g. "window 500"), this allows you to grab a smaller amount of data from the pane(s) than the pane's limit. For instance, you may have a really big limit for tmux history but using the same limit may end up on having slow performance on Extrakto. |
| `@maccyakto_clip_tool`       | `auto`   | Set this to whatever clipboard tool you would like maccyakto to use to copy data into your clipboard. `auto` will try to choose the correct clipboard for your platform. |
| `@maccyakto_clip_tool_run`   | `bg`     | Set this to `fg` to have your clipboard tool run in a foreground shell (enabling copying to clipboard using OSC52). |
| `@maccyakto_fzf_tool`        | `fzf`    | Set this to path of fzf if it can't be found in your `PATH`. |
| `@maccyakto_fzf_layout`      |`default` | Control the fzf layout which is "bottom-up" by default. If you prefer "top-down" layout instead set this to `reverse`. In fact, this value is passed to the fzf `--layout` parameter. Possible values are: `default`, `reverse` and `reverse-list` |
| `@maccyakto_open_tool`       | `auto`   | Set this to path of your own tool or `auto` to use your platforms *open* implementation. |
| `@maccyakto_copy_key`        | `enter`  | Key to copy selection to clipboard. |
| `@maccyakto_insert_key`      | `tab`    | Key to insert selection. |
| `@maccyakto_filter_key`      | `ctrl-f` | Key to toggle filter mode. |
| `@maccyakto_grab_key`        | `ctrl-g` | Key to toggle grab mode. |
| `@maccyakto_edit_key`        | `ctrl-e` | Key to run the editor. |
| `@maccyakto_open_key`        | `ctrl-o` | Key to run the open command. |
| `@maccyakto_default_opt`     | `word`   | **LEGACY** this option was removed in favor of the new filter mode. |

Example:

```
set -g @maccyakto_split_size "15"
set -g @maccyakto_clip_tool "xsel --input --clipboard" # works better for nvim
set -g @maccyakto_copy_key "tab"      # use tab to copy to clipboard
set -g @maccyakto_insert_key "enter"  # use enter to insert selection
```

### Custom Filters

You can define your own filters by creating a file in `~/.config/maccyakto/maccyakto.conf`:

```
[quote]
regex: ("[^"\n\r]+")
```

See [maccyakto.conf](maccyakto.conf) for syntax and other predefined filters.


---

# CLI

You can also use maccyakto as a standalone tool to extract tokens from text.

### Installation

For now simply clone the repository and link to the tool somewhere in your path:

```
git clone https://github.com/laktak/maccyakto
cd maccyakto
# assuming you `export PATH=$PATH:~/.local/bin` in your `.bashrc`:
ln -s $PWD/maccyakto.py ~/.local/bin/maccyakto
```

Requires Python 3.6+.

### CLI Usage

```
usage: maccyakto.py [-h] [--name] [-w] [-l] [--all] [-a ADD] [-p] [-u] [--alt] [-r] [-m MIN_LENGTH] [--warn-empty]

Extracts tokens from plaintext.

optional arguments:
  -h, --help            show this help message and exit
  --name                prefix filter name in the output
  -w, --words           extract "word" tokens
  -l, --lines           extract lines
  --all                 extract using all filters defined in maccyakto.conf
  -a ADD, --add ADD     add custom filter
  -p, --paths           short for -a=path
  -u, --urls            short for -a=url
  --alt                 return alternate variants for each match (e.g. https://example.com and example.com)
  -r, --reverse         reverse output
  -m MIN_LENGTH, --min-length MIN_LENGTH
                        minimum token length
  --warn-empty          warn if result is empty
```

# Contributions

Thanks go to all contributors for their ideas and PRs!

Please run `black` if you change any python code and run `shfmt` if you change any bash files.
