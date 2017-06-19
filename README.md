git-ff-all
==========

Git command for fast-forwarding all branches.

Installation
------------

1. Clone me
1. `chmod +x /path/to/git-ff-all.sh` (if it's not already)
2. `git config --global alias.ff-all '!/path/to/git-ff-all.sh'` (make sure to use an absolute path)

Usage
-----

Just run `git ff-all` in your repository's path, which will do the following:

- fetch & prune all remotes
- fast-forward the checked out branch (if possible)
- for all local branches with an upstream, fast-forward them if possible,
  without checking them out

```
$ cd /your/repository
$ git ff-all
Updating current branch...
Fetching origin
Updating a993fd3..529146f
Fast-forward
 some_binary_file   | Bin 0 -> 1707556 bytes
 some_text_file.txt |  64 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 some_binary_file
 create mode 100644 some_text_file.txt
Updating 'BranchThatsBehind'...
From .
   772438a..8a4acf9  origin/AnotherBranch -> AnotherBranch
Updating 'BranchThatsNotBehind'...
Done
```
