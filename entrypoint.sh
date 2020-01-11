#!/bin/sh -l

set -e

[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

echo "pwd"
pwd

docs_src=$GITHUB_WORKSPACE/docs
docs_html=$GITHUB_WORKSPACE/gh-pages
sphinx_doctree=$GITHUB_WORKSPACE/.doctree

echo "mkdir $docs_src"
mkdir $docs_src
echo "mkdir $docs_html"
mkdir $docs_html
echo "mkdir $sphinx_doctree"
mkdir $sphinx_doctree

# checkout branch docs
echo "cd $docs_src"
cd $docs_src
echo "git init"
git init
echo "git remote add origin https://github.com/$GITHUB_REPOSITORY.git"
git remote add origin https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git
echo "git fetch origin +$GITHUB_SHA:refs/remotes/origin/docs"
git fetch origin +$GITHUB_SHA:refs/remotes/origin/docs
echo "git checkout -B docs refs/remotes/origin/docs"
git checkout -B docs refs/remotes/origin/docs
echo "git log -1"
git log -1

# get author
author_name="$(git show --format=%an -s)"
author_email="$(git show --format=%ae -s)"
docs_sha8="$(echo ${GITHUB_SHA} | cut -c 1-8)"

# outputs
echo "::set-output name=name::"$author_name""
echo "::set-output name=email::"$author_email""
echo "::set-output name=docs_sha::$(echo ${GITHUB_SHA})"
echo "::set-output name=docs_sha8::"$docs_sha8""

# checkout branch gh-pages
echo "cd $docs_html"
cd $docs_html
echo "git init"
git init
echo "git remote add origin https://github.com/$GITHUB_REPOSITORY.git"
git remote add origin https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

# check remote branch exist first
echo "Checking remote branch gh-pages."
gh_pages_exist=$(git ls-remote --heads origin refs/heads/gh-pages)
if [ -z "$gh_pages_exist" ] 
then 
    echo "-> remote branch gh-pages not exist, auto create."
    echo "git checkout -B gh-pages"
    git checkout -B gh-pages
else
    echo "-> remote branch gh-pages exist, fetch."
    echo "git fetch origin +refs/heads/gh-pages:refs/remotes/origin/gh-pages"
    git fetch origin +refs/heads/gh-pages:refs/remotes/origin/gh-pages
    echo "git checkout -B gh-pages refs/remotes/origin/gh-pages"
    git checkout -B gh-pages refs/remotes/origin/gh-pages
    echo "git log -1"
    git log -1
fi

# git config
echo "git config user.name $author_name"
git config user.name $author_name
echo "git config user.email $author_email"
git config user.email $author_email

# sphinx-build
echo "sphinx-build -b html $docs_src/source $docs_html -E -d $sphinx_doctree"
sphinx-build -b html $docs_src/source $docs_html -E -d $sphinx_doctree

# commit and push
echo "git add ."
git add .
echo 'git commit --allow-empty -m "From $GITHUB_REF"'
git commit --allow-empty -m "From $GITHUB_REF $docs_sha8"
echo "git push origin gh-pages"
git push origin gh-pages
