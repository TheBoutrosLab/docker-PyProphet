ARG MINIFORGE_VERSION=26.1.1-2
ARG UBUNTU_VERSION=24.04
ARG CONDA_ENV_PATH=/opt/conda/envs/pyprophet

FROM condaforge/miniforge3:${MINIFORGE_VERSION} AS builder

ARG CONDA_ENV_PATH
ARG PYPROPHET_VERSION=3.0.15

# SciPy 1.18 returns floating-point ranks that PyProphet 3.0.15 uses as indices.
# Keep integer ranks for its monotone local-FDR calculation.
# Install PyProphet and its dependencies in a dedicated environment.
RUN mamba create -qy -p "${CONDA_ENV_PATH}" \
    --override-channels --strict-channel-priority \
    -c conda-forge -c bioconda \
    "pyprophet=${PYPROPHET_VERSION}" "scipy<1.18" && \
    mamba clean -afy

COPY src/prepare_image.py /usr/local/share/pyprophet/prepare_image.py

# Install the extension and configure PyProphet to use its shared directory.
RUN "${CONDA_ENV_PATH}/bin/python" /usr/local/share/pyprophet/prepare_image.py

# Deploy the environment and read-only extension cache into the runtime image.
FROM ubuntu:${UBUNTU_VERSION} AS final

ARG CONDA_ENV_PATH

COPY --from=builder "${CONDA_ENV_PATH}" "${CONDA_ENV_PATH}"
COPY --from=builder /opt/duckdb/extensions /opt/duckdb/extensions

ENV CONDA_ENV_PATH="${CONDA_ENV_PATH}" \
    PATH="${CONDA_ENV_PATH}/bin:${PATH}"

# Add the standard non-root user/group.
RUN groupadd -g 500001 bldocker && \
    useradd -r -u 500001 -g bldocker bldocker

USER bldocker

# Verify the command and its imports in the final runtime image.
RUN pyprophet --help

LABEL maintainer="Chenghao Zhu <czhu@sbpdiscovery.org>" \
      org.opencontainers.image.source="https://github.com/TheBoutrosLab/docker-PyProphet" \
      org.opencontainers.image.title="PyProphet" \
      org.opencontainers.image.description="PyProphet scoring and statistical validation of OpenSWATH results"
