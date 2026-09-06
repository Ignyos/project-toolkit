# dotnet-windows-desktop — Architecture

Informed by LAN Portal (this repo): a multi-project .NET solution with a desktop host process that
packages a backend and/or web frontend for local/LAN installation, plus an installer and self-update
flow. Not every project of this shape needs every component below — treat this as the reference
shape, not a mandatory checklist.

## Components

- One or more backend/service projects (for example an ASP.NET Core API).
- An optional web frontend project (for example Blazor Server) served by, or alongside, the backend.
- A desktop host project (WinForms/WPF) that is the actual thing a user double-clicks. It launches
  the backend/frontend as child processes and hosts a browser control (for example WebView2) pointed
  at the frontend's URL, so the desktop shell and the web UI are the same rendered content.
- A shared contracts project for DTOs used across the other projects, so request/response shapes are
  defined once.
- A test project covering the backend/service layer at minimum.

## Process model

The host is not just a launcher — it owns the lifecycle of its child processes: starting them,
detecting failure to start, and stopping them on shutdown. The host also carries its own UI chrome
(menu, status bar) independent of whatever the hosted web frontend renders.

## Version source of truth

Exactly one project file carries the checked-in `<Version>`. Every other project's published version
is resolved from that one source at build/publish time, not authored independently. A fourth
version-node value distinguishes a dev/test build from a production build (nonzero fourth node =
dev/test; zero or absent = production), so channel identity is recoverable from the version string
alone, without a separate flag or external lookup.

## Persistence

Local runtime settings/configuration are persisted in one embedded database (for example SQLite),
not scattered across multiple flat config files, whenever the application needs to read and write its
own configuration at runtime rather than only at deployment time.

## Installer

A generated installer (for example Inno Setup) packages the published output of every component
project into one artifact. The installer's own icon, wizard artwork, and shortcut icons should carry
the application's real branding — this needs explicit verification after any icon/logo change, since
default toolchain icons can silently persist depending on which build or launch path was actually
exercised.

## Update mechanism

A version manifest (version, download URL, checksum, published date, minimum supported version) is
published externally (for example via GitHub Pages) and polled by the running application. The
application distinguishes an available update from a required update using the manifest's
minimum-supported-version field, and defaults to informational-only unless a deliberate product
decision enables enforcement.

## Release channels

Dev and production are separate publish lanes with separate cadences: dev deploys are frequent
rehearsals; a production release is the event that actually ships to users and is what gates on
release notes, per the toolkit's Dual-Lane By Default assumption.
