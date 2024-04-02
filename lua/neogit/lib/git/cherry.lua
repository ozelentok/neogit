local M = {}
local git = require("neogit.lib.git")
local util = require("neogit.lib.util")

function M.list(upstream, head)
  local result = git.cli.cherry.verbose.args(upstream, head).call().stdout
  return util.reverse(util.map(result, function(cherry)
    local status, oid, subject = cherry:match("([%+%-]) (%x+) (.*)")
    return { status = status, oid = oid, subject = subject }
  end))
end

return M
