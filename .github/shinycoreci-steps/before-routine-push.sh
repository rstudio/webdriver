#!/bin/bash -e
git commit figs -m 'Re-build README.Rmd figures (GitHub Actions)' || echo "No figure changes to commit"
