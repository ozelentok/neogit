local git = require("neogit.lib.git")

local M = {}

function M.all()
  return git.cli["ls-files"].full_name.deleted.modified.exclude_standard.deduplicate.call_sync({ hidden = true }).stdout
end

function M.untracked()
  return git.cli["ls-files"].others.exclude_standard.call_sync({ hidden = true }).stdout
end

function M.all_tree()
  return git.cli["ls-tree"].full_tree.name_only.recursive.args("HEAD").call_sync({ hidden = true }).stdout
end

function M.diff(commit)
  return git.cli.diff.name_only.args(commit .. "...").call_sync({ hidden = true }).stdout
end

function M.relpath_from_repository(path)
  local result = git.cli["ls-files"].others.cached.modified.deleted.full_name
    .args(path)
    .show_popup(false)
    .call { hidden = true }

  return result.stdout[1]
end

return M
