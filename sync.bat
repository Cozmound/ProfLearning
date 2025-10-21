@echo off


git diff --quiet || git stash push -m "autosync"


git pull origin master


for /f %%i in ('git stash list ^| findstr "autosync"') do (
    git stash pop
    goto :after_stash
)

:after_stash

git add .
git diff --cached --quiet || (
    git commit -m "update"
    git push origin master
    goto :eof
)

echo Nothing to commit
pause
