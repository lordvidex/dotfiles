return {
  'ThePrimeagen/harpoon',
  dependencies = 'nvim-telescope/telescope.nvim',
  keys = {
    { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>",        desc = "Harpoon Add file" },
    { "<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Harpoon [M]enu" },
    { "<leader>n", "<cmd>lua require('harpoon.ui').nav_next()<CR>",          desc = "Harpoon [n]ext" },
    { "<leader>p", "<cmd>lua require('harpoon.ui').nav_prev()<CR>",          desc = "Harpoon [p]rev" },
    { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>",         desc = "Harpoon 1" },
    { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>",         desc = "Harpoon 2" },
    { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>",         desc = "Harpoon 3" },
    { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>",         desc = "Harpoon 4" },
    { "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>",         desc = "Harpoon 5" },
    { "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>",         desc = "Harpoon 6" },
    { "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<CR>",         desc = "Harpoon 7" },
    { "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<CR>",         desc = "Harpoon 8" },
    { "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<CR>",         desc = "Harpoon 9" },
  },
  config = function()
    require('harpoon').setup()
    local ok_telescope, telescope = pcall(require, 'telescope')
    if not ok_telescope then
      return
    end
    telescope.load_extension('harpoon')
  end
}
