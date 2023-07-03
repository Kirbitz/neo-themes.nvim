# <p align="center"><img src="./img/neo-themes.gif" alt="Neo Themes Img" /></p>

# :clipboard: Table of Contents

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
    - [Packer](#packer)
- [Setup](#setup)
- [Configuration](#configuration)
- [Screenshots](#screenshots)
- [License](#license)

<a name="introduction" />

# :sparkles: Introduction

Do you like Themes!?!?

But do you hate having to search the inter webs to find new themes for your neovim?

Well with this theme manager you don't have to search ever again.

This plugin gives you the ability to install and hot swap themes with ease.

<a name="requirements" />

# :zap: Requirements

- neovim `>= 0.8.0`
- For Unix systems: `git(1)`

<a name="installation" />

# :electric_plug: Installation

<a name="packer" />

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use("Kirbitz/neo-themes.nvim")
```

<a name="setup" />

# :wrench: Setup

```lua
require("neo_themes").setup()
```

<a name="configuration" />

## :hammer: Default configuration

```lua
local DEFAULT_SETTINGS = {
  install_directory = PathJoin(
    vim.fn.stdpath('data'),
    'site',
    'pack',
    'neo-themes',
    'start'
  ),
  cache_directory = PathJoin(vim.fn.stdpath('cache'), 'neo-themes'),
  git_clone = 'git -C %s clone %s --depth 1 --no-single-branch --progress',
  git_uri = 'https://github.com/%s.git',
  remove_completion = { --Removes these options from the completion list
    'blue',
    'darkblue',
    'default',
    'delek',
    'desert',
    'elford',
    'evening',
    'industry',
    'koehler',
    'morning',
    'murphy',
    'pablo',
    'peachpuff',
    'ron',
    'shine',
    'slate',
    'torte',
    'zellner',
  },
}
```

<a name="screenshots" />

## :camera: Screenshots

:no_entry_sign: Under Construction.

This will get filled once the GUI is up and running.

<a name="license" />

## :blue_book: License

[![](https://img.shields.io/badge/license-MIT-blue?style-flat-round)]()
