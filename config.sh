# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function before_install {
    # Uninstall oclint. See Travis-CI gh-8826
    brew cask uninstall oclint || true
    # Force to use GCC for open-mp support
    brew install gcc
    export CC=g++-7
    export CXX=g++-7
    get_macpython_environment $MB_PYTHON_VERSION venv
    source venv/bin/activate
    pip install --upgrade pip wheel
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    pytest -l --pyargs skcycling -v -s
}
