#!/usr/bin/env python3
"""Install DuckDB's SQLite extension and configure PyProphet to discover it."""

from pathlib import Path

# Dependencies are installed in the image, outside the repository lint environment.
# pylint: disable=import-error
import duckdb
import pyprophet
# pylint: enable=import-error

EXTENSION_DIRECTORY = Path("/opt/duckdb/extensions")
EXTENSION_CONFIG = {"extension_directories": [str(EXTENSION_DIRECTORY)]}


def install_sqlite_scanner():
    """Install the extension in a shared directory readable by every runtime user."""
    EXTENSION_DIRECTORY.mkdir(parents=True, exist_ok=True)
    with duckdb.connect(config=EXTENSION_CONFIG) as connection:
        connection.execute("INSTALL sqlite_scanner")

    for path in EXTENSION_DIRECTORY.rglob("*"):
        path.chmod(0o555 if path.is_dir() else 0o444)
    EXTENSION_DIRECTORY.chmod(0o555)


def configure_pyprophet():
    """Point PyProphet's DuckDB connections to the bundled extension."""
    package_directory = Path(pyprophet.__file__).parent
    replacements = {
        "duckdb.connect()": f"duckdb.connect(config={EXTENSION_CONFIG!r})",
        'duckdb.connect(":memory:")': (
            f'duckdb.connect(":memory:", config={EXTENSION_CONFIG!r})'
        ),
    }
    for path in package_directory.rglob("*.py"):
        source = path.read_text(encoding="utf-8")
        configured = source
        for original, replacement in replacements.items():
            configured = configured.replace(original, replacement)
        if configured != source:
            path.write_text(configured, encoding="utf-8")


def main():
    """Prepare the shared extension and PyProphet's connection configuration."""
    install_sqlite_scanner()
    configure_pyprophet()


if __name__ == "__main__":
    main()
