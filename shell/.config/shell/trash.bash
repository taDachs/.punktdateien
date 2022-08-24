#!/bin/bash

echo "---"
echo "$(ps -o stat= -p $PPID)"
echo "$(ps -o stat= -p $$)"
echo "---"
