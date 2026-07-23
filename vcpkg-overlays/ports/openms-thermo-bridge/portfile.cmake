
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OpenMS/openms-thermo-bridge
    REF "v${VERSION}"
    SHA512 0 
    HEAD_REF main
    PATCHES
        vcpkg-nethost-use.patch
)

vcpkg_find_acquire_program(PERL)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DOPENMS_THERMO_BRIDGE_DOWNLOAD_PREBUILT_MANAGED=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME OpenMSThermoBridge
    CONFIG_PATH lib/cmake/OpenMSThermoBridge
)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

#The upstreams ships no License file.