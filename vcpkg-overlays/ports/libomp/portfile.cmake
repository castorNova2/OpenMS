set(LIBOMP_VERSION "12.0.1")

vcpkg_download_distfile(ARCHIVE
    URLS
        # OpenMS own host, matches with what contrib already fetches
        "https://github.com/OpenMS/contrib-sources/releases/download/3.6.0/openmp-${LIBOMP_VERSION}.src.tar.xz"
        #Upstream as a second source if still online
        "https://github.com/llvm/llvm-project/releases/download/llvmorg-{LIBOMP_VERSION}/openmp-${LIBOMP_VERSION}.src.tar.xz"
    FILENAME "openmp-${LIBOMP_VERSION}.src.tar.xz"
    SHA512 554edf032995cf80cfb6c878b26510b6c4df09e6bd4813934ea523ff8e121900a91ec59c3d83ee0ba390fb83bcaf6d137f7f6019958b444bdfe6a2b35c1c8d08
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLIBOMP_INSTALL_ALIASES=OFF
        -DOPENMP_ENABLE_LIBOMPTARGET=OFF
        -DOPENMP_ENABLE_OMPT_TOOLS=OFF
        -DCMAKE_MACOSX_RPATH=ON
)

vcpkg_cmake_install()

if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/cmake/openmp")
    vcpkg_cmake_config_fixup(PACKAGE_NAME "openmp" CONFIG_PATH lib/cmake/openmp)
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.TXT")