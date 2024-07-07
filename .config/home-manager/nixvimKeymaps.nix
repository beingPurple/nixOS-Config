[
  {
    mode = "i";
    key = "<C-Space>";
    action = "<cmd>lua require('cmp').complete()<CR>";
  }
  {
    mode = ["i" "s"];
    key = "<Tab>";
    action = "<cmd>lua require('cmp').select_next_item()<CR>";
  }
  {
    mode = ["i" "s"];
    key = "<S-Tab>";
    action = "<cmd>lua require('cmp').select_prev_item()<CR>";
  }
  {
    mode = ["i" "c"];
    key = "<Down>";
    action = "<cmd>lua require('cmp').select_next_item()<CR>";
  }
  {
    mode = ["i" "c"];
    key = "<Up>";
    action = "<cmd>lua require('cmp').select_prev_item()<CR>";
  }
  {
    mode = "n";
    key = "<C-M-f>";
    action = "<cmd>lua vim.lsp.buf.format()<CR>";
  }
]
