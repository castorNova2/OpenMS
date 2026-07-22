# set(LIBOMP_VERSION "17.0.6")

# vcpkg_download_distfile(ARCHIVE
#     URLS
#         # OpenMS own host, matches with what contrib already fetches
#         # "https://github.com/OpenMS/contrib-sources/releases/download/3.6.0/openmp-${LIBOMP_VERSION}.src.tar.xz"
#         #Upstream as a second source if still online
#         "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LIBOMP_VERSION}/openmp-${LIBOMP_VERSION}.src.tar.xz"
#     FILENAME "openmp-${LIBOMP_VERSION}.src.tar.xz"
#     SHA512 836c48db873e3da64835913c2c1d80efaebdfc7061f153acc7b478ea0d73b9c546a09d70dd1465e3e92684947c4a9cb197886b29cbd42418a778faa56b08cc5e
# )

# # )
# vcpkg_extract_source_archive(
#     SOURCE_PATH
#     ARCHIVE "${ARCHIVE}"


# vcpkg_cmake_configure(
#     SOURCE_PATH "${SOURCE_PATH}"
#     OPTIONS
#         -DLIBOMP_INSTALL_ALIASES=OFF
#         -DOPENMP_ENABLE_LIBOMPTARGET=OFF
#         -DOPENMP_ENABLE_OMPT_TOOLS=OFF
#         -DCMAKE_MACOSX_RPATH=ON
# )

# vcpkg_cmake_install()

# if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/cmake/openmp")
#     vcpkg_cmake_config_fixup(PACKAGE_NAME "openmp" CONFIG_PATH lib/cmake/openmp)
# endif()

# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.TXT")
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO llvm/llvm-project
    REF llvmorg-17.0.6
    SHA512 5300a452e706c1b6183ba300233804d97e4468d2588c2c2e0cf59e56ee5c83f20b7e03f5c0782198c34c63653b3e12d7407e4e8bb8214bae7e6532fa22730443
    HEAD_REF main
)

vcpkg_find_acquire_program(PERL)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/llvm"

    OPTIONS
        -DLLVM_ENABLE_PROJECTS=openmp

        -DCMAKE_BUILD_TYPE=Release

        -DLIBOMP_INSTALL_ALIASES=OFF
        -DOPENMP_ENABLE_LIBOMPTARGET=OFF
        -DOPENMP_ENABLE_OMPT_TOOLS=OFF
        -DOPENMP_ENABLE_DOCS=OFF
        -DOPENMP_BUILD_TESTING=OFF

        -DLLVM_INCLUDE_TESTS=OFF
        -DLLVM_INCLUDE_EXAMPLES=OFF
        -DLLVM_INCLUDE_BENCHMARKS=OFF
        -DLLVM_INCLUDE_DOCS=OFF

        -DLLVM_ENABLE_TERMINFO=OFF
        -DLLVM_ENABLE_ZLIB=OFF
        -DLLVM_ENABLE_ZSTD=OFF
        -DLLVM_ENABLE_LIBXML2=OFF

        -DPERL_EXECUTABLE=${PERL}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME OpenMP
    CONFIG_PATH lib/cmake/openmp
)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_copy_pdbs()

file(INSTALL
    "${SOURCE_PATH}/openmp/LICENSE.TXT"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    RENAME copyright
)
