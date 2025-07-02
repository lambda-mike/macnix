# Add this to .git/hooks/pre-push in order to prevent push from badbranch
#!/usr/bin/env bash
branch_blocked=badbranch

if grep --silent "$branch_blocked"; then
    echo "Branch '$branch_blocked' is blocked." >&2
    exit 1
fi
