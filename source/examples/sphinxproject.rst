Example for Sphinx project
==========================

There is a repo ``mydoc``, it is Sphinx documentation source.

#. add file ``./.github/workflows/example-sphinx.yml``

    ::

        on: [push]

        jobs:
          build:
            name: Sphinx Pages Test
            runs-on: ubuntu-latest
            steps:
              - uses: seanzhengw/sphinx-pages@master
                id: sphinx-pages
                with:
                  github_token: ${{ secrets.GITHUB_TOKEN }}

#. commit
#. push
#. wait for the workflow
