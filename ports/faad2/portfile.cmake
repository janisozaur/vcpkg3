include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO knik0/faad2
    REF 2_9_1
    SHA512 1015f5b49baebf6c9404cfcd7b9d524cc76a57abcd1a46bb851463ae5226bfd8b80155b661708f66548466422855cd7aeec5676463cd1346c5fb1dc0821621ce
    HEAD_REF master
    PATCHES
        0001-Fix-non-x86-msvc.patch
        0002-Fix-unary-minus.patch
        0003-Initialize-pointers.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    build_decoder   FAAD_BUILD_BINARIES
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS ${FEATURE_OPTIONS}
)

vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/faad2 RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
vcpkg_copy_pdbs()
