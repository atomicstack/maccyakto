
# extrakto

## tmux plugin

When you work in tmux you often copy and paste text from the current buffer. With extrakto you can fuzzy find your text instead of selecting it by hand.

- press `prefix + e` to extract words to be copied to the clipboard
- press `prefix + tab` to extract words and insert them to the current pane

Requires Python 2/3 and [fzf](https://github.com/junegunn/fzf). Supports Linux (xclip) and macOS (pbcopy) clipboards.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add the plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'laktak/extrakto'

Hit `prefix + I` to fetch the plugin and source it.

You should now have all `extrakto` key bindings defined.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/laktak/extrakto ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/extrakto.tmux

Reload the tmux environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now have all `extrakto` key bindings defined.

### Options

```
# Note: these are the default options
set -g @extrakto_clip_key 'e'
set -g @extrakto_clip_opt 'wr'
set -g @extrakto_insert_key 'tab'
set -g @extrakto_insert_opt 'wr'
set -g @extrakto_split_direction 'v'
set -g @extrakto_split_size '6'
```
- @extrakto_clip_key: the key binding to copy to the clipboard
- @extrakto_clip_opt: the extract options when copying
- @extrakto_insert_key: the key binding to insert to the current pane
- @extrakto_insert_opt: the extract options when inserting
- @extrakto_split_direction: whether the tmux split will be 'v'ertical or 'h'orizontal
- @extrakto_split_size: the size of the tmux split

Available options for `extrakto_clip_opt` and `extrakto_insert_opt` are:
- `p` extract path tokens
- `u` extract url tokens
- `w` extract word tokens
- `r` reverse output

**tl;dr**: you probably want either `wr` (default) or `pur`.

## CLI

You can also use extrakto as a standalone tool to extract tokens from text.

### Installation

For now simply clone the repository and link to the tool somewhere in your path:

```
git clone https://github.com/laktak/extrakto
cd extrakto
# assuming you `export PATH=$PATH:~/.local/bin` in your `.bashrc`:
ln -s $PWD/extrakto.py ~/.local/bin/extrakto
```

Requires Python 2/3.

### CLI Usage

```
usage: extrakto.py [-h] [-p] [-u] [-w] [-r] [-m MIN_LENGTH]

Extracts tokens from plaintext.

optional arguments:
  -h, --help            show this help message and exit
  -p, --paths           extract path tokens
  -u, --urls            extract url tokens
  -w, --words           extract word tokens
  -r, --reverse         reverse output
  -m MIN_LENGTH, --min-length MIN_LENGTH
                        minimum token length
```