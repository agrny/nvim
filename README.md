# Neovim Configuration Setup Guide

This guide explains how to replicate this Neovim configuration on another machine.

## Overview

This is a **NvChad-based configuration** (v2.5) with custom plugins and LSP setups for Go, JavaScript/TypeScript, Python, Bash, and more.

## Prerequisites

### 1. System Requirements

**Neovim Version:** v0.11.6 or later (v0.10+ should work)
```bash
nvim --version
```

### 2. Required System Dependencies

#### Build Tools (Required for Treesitter compilation)
```bash
# Ubuntu/Debian
sudo apt install build-essential gcc g++ make git

# macOS
xcode-select --install

# Arch Linux
sudo pacman -S base-devel git
```

#### Optional but Recommended
- **Node.js & npm** (v18+): For some LSP servers and formatters
  ```bash
  # Ubuntu/Debian
  sudo apt install nodejs npm
  
  # macOS
  brew install node
  ```

- **Go** (if developing in Go): For gopls and Go tools
  ```bash
  # Ubuntu/Debian
  sudo apt install golang
  
  # macOS
  brew install go
  ```

- **Python 3** (if developing in Python): For python-lsp-server
  ```bash
  # Usually pre-installed, verify:
  python3 --version
  ```

## Installation Steps

### Step 1: Backup Existing Config (if any)

```bash
# Backup your existing nvim config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### Step 2: Clone This Configuration

```bash
# Copy the entire nvim config directory to the new machine
# Option A: If using git
cd ~/.config
git clone <your-nvim-config-repo> nvim

# Option B: If copying manually
# Copy the entire ~/.config/nvim directory to the new machine
```

### Step 3: First Launch - Automatic Setup

```bash
nvim
```

On first launch, the following will happen automatically:
1. **Lazy.nvim** will be bootstrapped and installed
2. **NvChad** (v2.5) will be downloaded
3. All **plugins** listed in `lazy-lock.json` will be installed
4. **Base46 theme** will be compiled

**Wait for all plugins to finish installing.** You'll see progress notifications.

### Step 4: Install Language Parsers (Treesitter)

The treesitter parsers are configured to auto-install, but if they don't compile automatically, run:

```bash
# Inside nvim
:TSInstall go python javascript typescript bash json yaml markdown
```

**If TSInstall fails or hangs**, you'll need to compile parsers manually (see Troubleshooting section below).

### Step 5: Install LSP Servers via Mason

```bash
# Inside nvim
:MasonInstall gopls lua-language-server bash-language-server typescript-language-server stylua gofumpt prettierd
```

Or open Mason UI:
```vim
:Mason
```

Then press `i` to install the following:
- **gopls** (Go)
- **lua-language-server** (Lua)
- **bash-language-server** (Bash)
- **typescript-language-server** (JS/TS)
- **html-lsp** (HTML)
- **css-lsp** (CSS)
- **clangd** (C/C++)
- **stylua** (Lua formatter)
- **gofumpt** (Go formatter)
- **prettierd** (JS/TS formatter)

### Step 6: Verify Everything Works

```bash
# Check health
:checkhealth

# Check LSP status (open a Go/JS file first)
:LspInfo

# Check treesitter
:TSModuleInfo
```

## What Gets Auto-Installed

### Plugins (via Lazy.nvim)
All plugins in `lazy-lock.json` will be automatically installed:
- NvChad core components
- nvim-treesitter
- nvim-lspconfig
- conform.nvim (formatting)
- nvim-cmp (completion)
- copilot.vim
- orgmode
- oil.nvim (file explorer)
- And more...

### LSP Servers (via Mason - requires manual step)
Must be installed via `:Mason`:
- gopls, lua-language-server, bash-language-server, etc.

### Treesitter Parsers
Should auto-install on first file open, but can be manually triggered with `:TSInstall`

## Configuration Files Included

```
~/.config/nvim/
├── init.lua                     # Entry point
├── lazy-lock.json              # Plugin versions (lockfile)
├── lua/
│   ├── autocmds.lua            # Auto commands
│   ├── mappings.lua            # Key mappings
│   ├── options.lua             # Vim options
│   ├── chadrc.lua              # NvChad theme & UI config
│   ├── configs/
│   │   ├── conform.lua         # Formatter config
│   │   ├── lazy.lua            # Lazy.nvim config
│   │   └── lspconfig.lua       # LSP server configs
│   └── plugins/
│       └── init.lua            # Plugin specifications
└── SETUP.md                     # This file
```

## Important Features Configured

### LSP Servers Configured
- **Go**: gopls with semantic tokens, gofumpt formatting
- **Lua**: lua-language-server
- **JavaScript/TypeScript**: ts_ls
- **Bash**: bashls
- **HTML/CSS**: html-lsp, cssls
- **C/C++**: clangd

### Treesitter Languages
Go, Python, JavaScript, TypeScript, Bash, JSON, YAML, Markdown, HTML, CSS, Lua

### Custom Plugins
- **copilot.vim**: GitHub Copilot integration
- **oil.nvim**: File explorer (replaces nvim-tree)
- **orgmode**: Org-mode support
- **nvim-surround**: Surround text objects
- **which-key**: Key binding hints
- **shellcheck.nvim**: Shell script linting

### Key Features
- **Semantic highlighting** for Go functions
- **Bold function names** in Go
- **Format on save** (configurable)
- **Italic comments**
- **Oil.nvim** file browser (press `<C-n>` or run `:Oil`)

## Troubleshooting

### Issue: Treesitter parsers won't compile

If `:TSInstall` hangs or fails, you need to manually compile them:

```bash
# For each language, compile the parser manually:
cd ~/.cache/nvim/tree-sitter-go
gcc -o go.so -shared src/parser.c -I./src -Os -lstdc++ -fPIC
cp go.so ~/.local/share/nvim/site/parser/

# Copy queries
mkdir -p ~/.local/share/nvim/site/queries/go
cp queries/*.scm ~/.local/share/nvim/site/queries/go/
```

Repeat for other languages (python, javascript, etc.).

### Issue: LSP servers not starting

1. Check they're installed:
   ```vim
   :Mason
   ```

2. Check LSP status in a file:
   ```vim
   :LspInfo
   ```

3. Install missing servers:
   ```vim
   :MasonInstall gopls lua-language-server
   ```

### Issue: Copilot not working

```vim
:Copilot setup
```

Follow the authentication prompts.

### Issue: Missing syntax highlighting

1. Check treesitter:
   ```vim
   :TSModuleInfo
   ```

2. Ensure parsers are installed:
   ```vim
   :TSInstall go python javascript
   ```

3. Check if highlighting is enabled:
   ```vim
   :lua print(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil)
   ```

### Issue: Theme/colors look wrong

Regenerate Base46 cache:
```vim
:Lazy build base46
```

## Platform-Specific Notes

### Linux
Everything should work out of the box if build-essential is installed.

### macOS
- Install Xcode Command Line Tools first
- Some parsers may need additional flags, but usually work fine

### Windows (WSL)
- Recommended: Use WSL2 with Ubuntu
- Follow Linux instructions
- **Clipboard integration with Windows is configured** - see WSL Clipboard Setup section below

### Windows (Native)
- Requires MinGW or MSVC for treesitter compilation
- Some plugins may have issues
- Consider using WSL instead for better compatibility

## Differences Between Machines

### What Transfers
✅ All config files (`.lua`)
✅ Plugin specifications
✅ Key mappings & options
✅ Theme & UI settings
✅ LSP configurations

### What Doesn't Transfer (must reinstall)
❌ Plugin binaries (auto-installs via Lazy)
❌ LSP server binaries (install via Mason)
❌ Treesitter parsers (compiles on first run or via `:TSInstall`)
❌ Mason packages (install via `:Mason`)
❌ Copilot authentication

## Quick Start Commands

After copying the config to a new machine:

```bash
# 1. Launch nvim (plugins auto-install)
nvim

# 2. Inside nvim, install LSP servers
:MasonInstall gopls lua-language-server bash-language-server typescript-language-server

# 3. Install treesitter parsers (if not auto-installed)
:TSInstall go python javascript typescript bash json yaml markdown

# 4. Check health
:checkhealth

# 5. Test by opening a Go file
:e test.go
```

## Updating the Config

To update plugins on a new machine after pulling config changes:

```vim
:Lazy sync
```

To update LSP servers:
```vim
:MasonUpdate
```

## Support

If you encounter issues:
1. Run `:checkhealth` and look for errors
2. Check `:LspInfo` when in a code file
3. Check `:Lazy` for plugin issues
4. Check `:Mason` for LSP server issues

## WSL Clipboard Setup (Windows + WSL)

This configuration includes clipboard integration between Neovim in WSL and the Windows host system using `win32yank.exe`.

### What This Enables

- ✅ Yank (copy) text in Neovim with `y` → paste in Windows apps (Ctrl+V)
- ✅ Copy text in Windows apps (Ctrl+C) → paste in Neovim with `p`
- ✅ Bidirectional clipboard sharing between WSL and Windows
- ✅ Works with standard Vim keybindings (no special commands needed)

### Installation Steps

#### 1. Install win32yank.exe

```bash
# Download win32yank
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip

# Extract and install to user bin directory
cd /tmp
unzip -o win32yank.zip
mkdir -p ~/.local/bin
mv win32yank.exe ~/.local/bin/
chmod +x ~/.local/bin/win32yank.exe

# Add ~/.local/bin to PATH (if not already added)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### 2. Verify Installation

```bash
# Test that win32yank is accessible
win32yank.exe -h

# Test clipboard functionality
echo "test clipboard" | win32yank.exe -i
win32yank.exe -o
```

You should see "test clipboard" output, confirming it works.

#### 3. Configuration (Already Included)

The clipboard configuration is already included in `lua/options.lua`:

```lua
-- WSL clipboard integration using win32yank
vim.g.clipboard = {
	name = "win32yank-wsl",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf",
	},
	cache_enabled = 0,
}
```

This configuration:
- Uses `win32yank.exe` for both copy and paste operations
- Handles line ending conversions (CRLF ↔ LF) automatically
- Maps both `+` and `*` registers to the Windows clipboard

### Usage

Once configured, clipboard operations work seamlessly with standard Vim keybindings:

#### Copying from Neovim to Windows

```vim
" Visual mode - select and yank
v          " Enter visual mode
j j j      " Select multiple lines
y          " Yank to clipboard (now in Windows clipboard!)

" Yank entire line
yy         " Yank current line to clipboard

" Yank from cursor to end of line
y$

" Yank entire file
ggVG       " Select all
y          " Yank to clipboard
```

After yanking, you can paste in any Windows application with `Ctrl+V`.

#### Pasting from Windows to Neovim

1. Copy text in any Windows application (Ctrl+C)
2. In Neovim:
   ```vim
   p          " Paste after cursor
   P          " Paste before cursor
   "+p        " Explicitly paste from system clipboard
   ```

#### Advanced Usage

```vim
" Explicitly use system clipboard register
"+yy       " Yank line to system clipboard
"*yy       " Alternative system clipboard register

" Paste from system clipboard
"+p        " Paste from system clipboard
"*p        " Alternative

" Visual block mode with clipboard
<C-v>      " Visual block mode
j j j      " Select block
"+y        " Yank block to clipboard
```

### Troubleshooting

#### Issue: Clipboard not working

1. **Check win32yank.exe is in PATH:**
   ```bash
   which win32yank.exe
   # Should output: /home/yourusername/.local/bin/win32yank.exe
   ```

2. **Test win32yank directly:**
   ```bash
   echo "test" | win32yank.exe -i
   win32yank.exe -o
   ```

3. **Restart your terminal** to ensure PATH changes are loaded:
   ```bash
   source ~/.bashrc
   ```

4. **Check Neovim clipboard configuration:**
   ```vim
   :lua print(vim.inspect(vim.g.clipboard))
   ```

#### Issue: win32yank.exe not found

If you get "command not found", ensure:
- `~/.local/bin` is in your PATH
- You've restarted your terminal or run `source ~/.bashrc`
- The executable has correct permissions: `chmod +x ~/.local/bin/win32yank.exe`

#### Issue: Line endings are wrong (^M characters)

The configuration handles line ending conversions automatically:
- `--crlf` flag converts LF to CRLF when copying to Windows
- `--lf` flag converts CRLF to LF when pasting to WSL

If you still see issues, the configuration is set correctly. The problem may be with files that have mixed line endings.

### Alternative: Using Built-in Windows Tools

If you prefer not to install win32yank.exe, you can use clip.exe and powershell.exe instead:

```lua
-- In lua/options.lua, replace the clipboard configuration with:
vim.g.clipboard = {
	name = "wsl-clipboard",
	copy = {
		["+"] = "/mnt/c/Windows/system32/clip.exe",
		["*"] = "/mnt/c/Windows/system32/clip.exe",
	},
	paste = {
		["+"] = 'powershell.exe -c Get-Clipboard',
		["*"] = 'powershell.exe -c Get-Clipboard',
	},
	cache_enabled = 0,
}
```

**Note:** This method is slower for paste operations but requires no additional installation.

## Version Info

- **Neovim**: v0.11.6 (works with v0.10+)
- **NvChad**: v2.5
- **Lazy.nvim**: Latest stable
- **Theme**: OneDark (configurable in `chadrc.lua`)
- **Clipboard**: win32yank v0.1.1 (WSL only)
