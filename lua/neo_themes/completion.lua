local completionData = {}

completionData.installOptions = {
  'abstract-cs',
  'ariake',
  'aurora',
  'blue-moon',
  'boo',
  'catppuccin',
  'edge',
  'gloombuddy',
  'material',
  'modus',
  'monokai',
  'moonfly',
  'neon',
  'nightfly',
  'nvcode',
  'nvim-deus',
  'nvim-hybrid',
  'oceanic-next',
  'ofirkai',
  'omni',
  'onebuddy',
  'one-nvim',
  'oxocarbon',
  'sonokai',
  'space-nvim',
  'starry',
  'tokyonight',
  'vim-code-dark',
  'vscode',
  'zephyr',
  ['abstract-cs'] = 'Abstract-IDE/Abstract-cs',
  ariake = 'jim-at-jibba/ariake-vim-colors',
  aurora = 'ray-x/aurora',
  ['blue-moon'] = 'kyazdani42/blue-moon',
  boo = 'rockerBOO/boo-colorscheme-nvim',
  catppuccin = 'catppuccin/nvim',
  edge = 'sainnhe/edge',
  gloombuddy = 'bkegley/gloombuddy',
  material = 'marko-cerovac/material.nvim',
  modus = 'ishan9299/modus-theme-vim',
  monokai = 'tanvirtin/monokai.nvim',
  moonfly = 'bluz71/vim-moonfly-colors',
  neon = 'rafamadriz/neon',
  nightfly = 'bluz71/vim-nightfly-colors',
  nvcode = 'ChristianChiarulli/nvcode-color-schemes.vim',
  ['nvim-deus'] = 'theniceboy/nvim-deus',
  ['nvim-hybrid'] = 'PHSix/nvim-hybrid',
  ['oceanic-next'] = 'mhartington/oceanic-next',
  ofirkai = 'ofirgall/ofirkai.nvim',
  omni = 'yonlu/omni.vim',
  onebuddy = 'Th3WhitWolf/onebuddy',
  ['one-nvim'] = 'Th3WhitWolf/one-nvim',
  oxocarbon = 'nyoom-engineering/oxocarbon.nvim',
  sonokai = 'sainnhe/sonokai',
  ['space-nvim'] = 'Th3WhitWolf/space-nvim',
  starry = 'ray-x/starry.nvim',
  tokyonight = 'folke/tokyonight.nvim',
  ['vim-code-dark'] = 'tomasiser/vim-code-dark',
  vscode = 'Mofiqul/vscode.nvim',
  zephyr = 'nvimdev/zephyr-nvim',
}

completionData.themeOptions = vim.fn.getcompletion('', 'color')

completionData.themeOptionsIndex = vim.fn.getcompletion('', 'color')
completionData.size = 0
completionData.currentThemeIndex = 0

for _, opt in ipairs(completionData.themeOptions) do
  completionData.size = completionData.size + 1
  completionData.themeOptionsIndex[opt] = completionData.size
end

completionData.setCurrentThemeIndex = function(theme)
  completionData.currentThemeIndex = completionData.themeOptionsIndex[theme]
end

return completionData
