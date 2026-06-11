-- Recommended tools:
-- * hoogle: https://github.com/ndmitchell/hoogle/blob/master/docs/Install.md
--    * `cabal install hoogle --overwrite-policy=always`
-- * fast-tags: https://github.com/elaforge/fast-tags
--    * `stack install fast-tags
return {
  "mrcjkb/haskell-tools.nvim",
  version = "^10",
  -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
  -- No need for lazy.nvim to lazy-load it.
  lazy = false,
}
