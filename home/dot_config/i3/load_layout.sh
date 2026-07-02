#!/bin/sh

# First we append the saved layout of workspace N to workspace M
i3-msg "workspace --no-auto-back-and-forth 1; append_layout ~/.config/i3/workspace-1.json"
