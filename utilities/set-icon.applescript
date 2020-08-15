#!/usr/bin/env osascript

use framework "Foundation"
use framework "AppKit"
use scripting additions

on run argv
	set sourcePath to (item 1 of argv)
	set destPath to (item 2 of argv)
	set imageData to (current application's NSImage's alloc()'s initWithContentsOfFile:sourcePath)
	(current application's NSWorkspace's sharedWorkspace()'s setIcon:imageData forFile:destPath options:2)
end run
