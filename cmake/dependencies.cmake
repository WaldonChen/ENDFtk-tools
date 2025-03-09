list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/.cmake)
# include( shacl_FetchContent )
include( FetchContent )
#######################################################################
# Declare project dependencies
#######################################################################

FetchContent_Declare( FastFloat
    # GIT_REPOSITORY  ../../fastfloat/fast_float
    # GIT_TAG         00c8c7b0d5c722d2212568d915a39ea73b08b973 # tag: v6.1.6
    URL               https://github.com/fastfloat/fast_float/archive/refs/tags/v8.0.0.tar.gz
    URL_MD5           c18c85224181b42da65e945152746e41
    DOWNLOAD_DIR      ${CMAKE_SOURCE_DIR}/downloads
    DOWNLOAD_NAME     fast_float-v8.0.0.tar.gz
    )

FetchContent_Declare( spdlog
    # GIT_REPOSITORY  ../../gabime/spdlog
    # GIT_TAG         27cb4c76708608465c413f6d0e6b8d99a4d84302 # tag: v1.14.1
    URL             https://github.com/gabime/spdlog/archive/refs/tags/v1.15.1.tar.gz
    URL_MD5         3a8f758489a1bf21403eabf49e78c3a4
    DOWNLOAD_DIR    ${CMAKE_SOURCE_DIR}/downloads
    DOWNLOAD_NAME   spdlog-v1.15.1.tar.gz
    )
set( SPDLOG_BUILD_PIC CACHE INTERNAL BOOL ON )
# thenext line prevents spdlog from populating the .cmake/packages folder
set( CMAKE_EXPORT_NO_PACKAGE_REGISTRY ON )

if (tools.installation)
    set( SPDLOG_INSTALL CACHE INTERNAL BOOL ON )
else()
    set( SPDLOG_INSTALL CACHE INTERNAL BOOL OFF )
endif()

#######################################################################
# Load dependencies
#######################################################################

FetchContent_MakeAvailable(
    FastFloat
    spdlog
    )

if (tools.tests)
  FetchContent_Declare( Catch2
      # GIT_REPOSITORY  ../../catchorg/Catch2
      # GIT_TAG         3f0283de7a9c43200033da996ff9093be3ac84dc # tag: v3.3.2
      URL             https://github.com/catchorg/Catch2/archive/refs/tags/v3.8.0.tar.gz
      URL_MD5         a13f1f54d1f4e8238e36669e94b8097b
      DOWNLOAD_DIR    ${CMAKE_SOURCE_DIR}/downloads
      DOWNLOAD_NAME   catch2-v3.8.0.tar.gz
      )

  FetchContent_MakeAvailable(Catch2)
endif()

if (tools.python)
  FetchContent_Declare( pybind11
      # GIT_REPOSITORY  ../../pybind/pybind11
      # GIT_TAG         a2e59f0e7065404b44dfe92a28aca47ba1378dc4 # tag: v2.13.6
      URL             https://github.com/pybind/pybind11/archive/refs/tags/v2.13.6.tar.gz
      URL_MD5         a04dead9c83edae6d84e2e343da7feeb
      DOWNLOAD_DIR    ${CMAKE_SOURCE_DIR}/downloads
      DOWNLOAD_NAME   pybind11-v2.13.6.tar.gz
      )
  FetchContent_MakeAvailable(pybind11)
endif()
