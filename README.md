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
| Miniforge | 26.1.1-2 |
| Ubuntu | 24.04 |

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
