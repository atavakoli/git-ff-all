#!/bin/bash

# The below is a subshell command that will fast-forward all branches to their
# configured upstream (including the currently checked-out one). It first does a
# fetch (by merit of git-pull, which also fast-forwards the current branch and
# prunes any stale remote branches), followed by a branch-by-branch fast-forward
# for any branches that have an upstream configured.
#
# Branches that cannot be fast-forwarded are not touched.
#
# For xterm terminals, the output is color-coded.

(
if [ "${TERM:0:5}" == "xterm" ]; then
  export clrRed="\\033[1;31m"
  export clrGreen="\\033[1;32m"
  export clrOff="\\033[0m"
else
  export greenClr=
  export redClr=
  export normalClr=
fi

echo "echo -e \"${clrGreen}Updating current branch...${clrOff}\"";
echo 'git pull --ff-only --all --prune' && git for-each-ref --shell --format="
if [ %(refname) != \"\$(git symbolic-ref HEAD 2>/dev/null)\" ]; then
  if [ -n %(upstream:short) ]; then
    git show-ref --verify -q %(upstream)
    if [ \"\$?\" -eq 0 ]; then
      echo -e \"${clrGreen}Updating %(refname:short)...${clrOff}\"
      git fetch . %(upstream:short):%(refname:short)
    else
      echo -e \"${clrRed}Removing stale upstream for %(refname:short)...${clrOff}\"
      git branch --unset-upstream %(refname:short)
    fi
  fi
fi" refs/heads
echo "echo -e \"${clrGreen}Done${clrOff}\""
) | sh | less -XRE
