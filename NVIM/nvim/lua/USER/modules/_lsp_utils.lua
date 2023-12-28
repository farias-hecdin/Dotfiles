local D = require("USER.modules.utils.dir")

-- SUMMARY
-- corn.nvim.fork
-- code_runner.nvim

return {
  {
    url = "https://github.com/CRAG666/code_runner.nvim.git",
    cmd = { "RunCode", "RunFile", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects" },
    config = function ()
      require('code_runner').setup({
        term = {
          size = 5,
        },
        filetype = {
          go = "go run",
          java = { "cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt &&", "rm -rf *.class" },
          lua = "lua",
          php = "php",
          python = "python3 -u",
          sh = "bash",
          typescript = "deno run",
        },
      })
    end
  },
}
