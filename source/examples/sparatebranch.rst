Example for separate docs at other branch
=========================================

There are two branchs in repo ``myproject``, branch ``master`` and branch ``docs``.

The program source at branch ``master``.

The Sphinx documentation source at branch ``docs``.

To build GitHub Pages from branch ``docs``, add workflow to branch ``docs`` only.

#. switch to branch ``docs``
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
                  create_readme: true

#. commit
#. push ``docs``
#. wait for the workflow
