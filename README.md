# Sphinx Pages

This GitHub Action build html documentation by Sphinx, and push to branch gh-pages.

## Manual Settings

Select gh-pages branch as GitHub Pages source at repository settings.

## Branch for workflow

Don't use this GitHub Action at branch `gh-pages`.

Setup workflow at branch `master` or `docs` may be a good idea.

## Usage

`example-sphinx.yml`

    on: [push]

    jobs:
      build:
        name: Push Sphinx Pages
        runs-on: ubuntu-latest
        steps:
        - uses: seanzhengw/sphinx-pages@master
          with:
            github_token: ${{ secrets.GITHUB_TOKEN }}
            create_readme: true

## Example Usage for standalone Sphinx documentation

There is a repo `mydoc`, it is Sphinx documentation source.

put `example-sphinx.yml` into `mydoc/.github/workflows/`

## Example Usage for separate docs to other branch

There are two branchs in repo `myproject`, branch `master` and branch `docs`.

The program source at branch `master`.

The Sphinx documentation source at branch `docs`.

To build GitHub Pages from branch `docs`, put `example-sphinx.yml` to branch `docs` only at `myproject/.github/workflows/`.

## Self Example

See [https://seanzhengw.github.io/sphinx-pages](https://seanzhengw.github.io/sphinx-pages/), it from branch [example](https://github.com/seanzhengw/sphinx-pages/tree/example).
