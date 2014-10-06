#!/bin/bash

# commit for testing gh behavior

kramdown --entity-output=:symbolic source/outline.html.kramdown > build/index.html
 
