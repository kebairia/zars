-- Copyright (c) 2020-2021 Zakaria Kebairia
-- MIT license, see LICENSE for more details.
-- stylua: ignore
--
-- colors: 
----------
-- black:    #171717 
-- gray_e:   #515151  
-- gray_a:   #c4c4c4  
-- blue_a:   #0b98de 
-- orange_e: #fd9014 
-- red_b:    #cc241d 
-- red_e:    #ae0000
--
local colors = {
  black        = '#171717',
  white        = '#ebdbb2',
  red          = '#cc241d',
  green        = '#b8bb26',
  blue         = '#0037cd',
  yellow       = '#ffaf00',
  orange       = '#fd9014',
  magenta      = '#620085',
  gray         = '#515151',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
}

return {
  normal = {
    a = { bg = colors.blue, fg = colors.white },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.black, fg = colors.gray },
  },
  insert = {
    a = { bg = colors.orange, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.black, fg = colors.gray },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.black, fg = colors.gray },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black },
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  command = {
    a = { bg = colors.red, fg = colors.black },
    b = { bg = colors.gray, fg = colors.black },
    c = { bg = colors.black, fg = colors.gray },
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.gray },
    b = { bg = colors.darkgray, fg = colors.gray },
    c = { bg = colors.darkgray, fg = colors.gray },
  },
}
