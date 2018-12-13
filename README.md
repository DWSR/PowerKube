# PowerKube

## Description

A PowerShell-native replacement for the `kubectl` binary.

## Motivation

As an avid PowerShell user, one of the things that I enjoy the most is its
object-oriented nature. As `kubectl` is written primarily in the Linux/Unix
paradigm of everything being a string rather than an object, it can sometimes
be difficult or cumbersome to work with, especially on Windows where the
availability of GNU tools such as `sed` are not always present. While some
would view this as a drawback, instead I think that this presents an
opportunity to fill the gap by providing an object-oriented experience.

## Requirements

* PowerShell Core 6.1 or later (this might work in Windows PowerShell 5.1 or
  later, but it's untested)

## Getting Started with Development

1. Install the .Net Core SDK and PowerShell
1. Invoke `scripts/init.ps1`, which will install [PSDepend](https://github.com/RamblingCookieMonster/PSDepend/) and [psake](https://github.com/psake/psake)
   if not already present.
1. Run `Invoke-psake -Task InstallPSDepends` to install all PS dependencies.
1. Start hacking!

## Building

1. Follow the instructions under [Getting Started with Development](#getting_started_with_development)
1. Run `Invoke-psake`
