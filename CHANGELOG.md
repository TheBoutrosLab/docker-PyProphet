# Changelog

All notable changes to the PyProphet Docker image.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.15] - 2026-11-27

### Fixed

- Bundle DuckDB's SQLite extension in a shared read-only cache and configure
  PyProphet connections with `extension_directories` so arbitrary runtime UIDs/GIDs
  can reuse it without home-directory overrides or runtime downloads
  ([#2](https://github.com/TheBoutrosLab/docker-PyProphet/issues/2)).
- Constrain SciPy below 1.18 to prevent floating-point rank indices from
  crashing PyProphet 3.0.15 monotone local-FDR estimation.

## [3.0.15] - 2026-11-25

### Added

- Add a PyProphet 3.0.15 image built with Miniforge 26.1.1-2 and Ubuntu 24.04.
- Install PyProphet from Bioconda in a dedicated environment and check its help
  command as the non-root user in the final runtime image during builds.
- Configure publication to `ghcr.io/theboutroslab/pyprophet` for `linux/amd64`.
