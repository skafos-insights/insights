#!/bin/sh

# release_ctl eval --mfa "Insights.ReleaseTasks.migrate/1" --argv -- "$@"

release_ctl eval --mfa migrate --argv -- "$@"
