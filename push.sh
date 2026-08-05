npm run build || exit
git add . || exit
git commit -m "update my blog" || exit
git push origin master || exit
