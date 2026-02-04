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
- Ensure WSL has access to GUI clipboard if using system clipboard

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

## Version Info

- **Neovim**: v0.11.6 (works with v0.10+)
- **NvChad**: v2.5
- **Lazy.nvim**: Latest stable
- **Theme**: OneDark (configurable in `chadrc.lua`)
