# docker-PyProphet

Docker image for [PyProphet](https://github.com/PyProphet/pyprophet), a tool for
semi-supervised scoring and statistical validation of OpenSWATH results.

This image is maintained by the Boutros Lab and installs PyProphet from Bioconda
in a dedicated Miniforge/Conda environment on an Ubuntu runtime image. It provides
the `pyprophet` command for scoring, error-rate estimation, and export. OpenSWATH
extraction and TRIC alignment run in separate images.

## Version

| Component | Version |
|-----------|---------|
| PyProphet | 3.0.15 |
| SciPy | <1.18 |
| Miniforge | 26.1.1-2 |
| Ubuntu | 24.04 |

SciPy is constrained below 1.18 because PyProphet 3.0.15 uses integer ranks
from `scipy.stats.rankdata` as array indices during monotone local-FDR
estimation. SciPy 1.18 returns floating-point ranks and causes an `IndexError`.

## Bundled DuckDB SQLite extension

The image installs `sqlite_scanner` into `/opt/duckdb/extensions` during the build,
using the DuckDB version and platform in the PyProphet environment. The cache is
copied into the final image and made read-only and readable by every runtime
UID/GID.

The build helper `src/prepare_image.py` installs the extension and patches
PyProphet's `duckdb.connect()` and `duckdb.connect(":memory:")` calls to use this
shared cache through `extension_directories`. This source patch is applied only
inside the image and does not change statistical settings. Review the connection
calls when upgrading PyProphet.

Extension discovery is independent of runtime username and `HOME`; neither the
image nor the pipeline needs to override `HOME`. Apptainer execution still needs
verification on the deployment cluster.

Tracked in [issue #2](https://github.com/TheBoutrosLab/docker-PyProphet/issues/2).

## Discussions

- [Issue tracker](https://github.com/TheBoutrosLab/docker-PyProphet/issues) to report errors and enhancement ideas.
- Discussions can take place in [docker-PyProphet Discussions](https://github.com/TheBoutrosLab/docker-PyProphet/discussions).
- [docker-PyProphet pull requests](https://github.com/TheBoutrosLab/docker-PyProphet/pulls) are also open for discussion.

## Contributors

Please see the list of [Contributors](https://github.com/TheBoutrosLab/docker-PyProphet/graphs/contributors) at GitHub.

## References

1. PyProphet project documentation: <https://github.com/PyProphet/pyprophet>
2. PyProphet CLI and API documentation: <https://pyprophet.readthedocs.io/>
3. Bioconda package recipe: <https://github.com/bioconda/bioconda-recipes/blob/master/recipes/pyprophet/meta.yaml>

## License

Author: Chenghao Zhu

The code and container recipes in docker-PyProphet are licensed under the
BSD 3-Clause License (`BSD-3-Clause`). See [LICENSE](LICENSE) for the terms.

Bundled software retains its respective upstream license.

Copyright (C) 2026 Sanford Burnham Prebys Medical Discovery Institute ("Boutros Lab")
