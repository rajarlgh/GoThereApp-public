param(
  [string]$PrivateRemote = "origin",
  [string]$PublicRemote = "public"
)

$currentBranch = (git branch --show-current).Trim()

if (-not $currentBranch) {
  Write-Error "Could not determine the current git branch."
  exit 1
}

$workingTree = git status --porcelain
if ($workingTree) {
  Write-Error "Working tree is not clean. Commit or stash changes before syncing."
  exit 1
}

git push $PrivateRemote $currentBranch
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

git push $PublicRemote $currentBranch
exit $LASTEXITCODE