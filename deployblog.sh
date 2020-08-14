#!/bin/bash

hugo -D -d $HOME/gitprojects/mowestusa.github.io
cd $HOME/gitprojects/mowestusa.github.io
git add .
git commit -m "Blog Updated on $(date)"
git push

