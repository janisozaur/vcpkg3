include(vcpkg_common_functions)
vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO nih-at/libzip
	REF ab882fdd77c85f6c4723543b0d054943420a2786
	SHA512 3d8c5e64c567d2b91670ea041228d74cc8415116dfeb5c9bcf587ab817618eace668c5171122eeccf2a5f25242c2439c5f60b361f99a06274ab58aea720fe0bb
	HEAD_REF rel-1-4-0
)

# Patch cmake and configuration to allow static builds
vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/cmake_dont_build_more_than_needed.patch"
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS -DBUILD_SHARED_LIBS=OFF
    )
else()
    vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS -DBUILD_SHARED_LIBS=OFF
    )
endif()

vcpkg_install_cmake()

# Move zipconf.h to include and remove include directories from lib
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/libzip/include/zipconf.h ${CURRENT_PACKAGES_DIR}/include/zipconf.h)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/libzip ${CURRENT_PACKAGES_DIR}/debug/lib/libzip)

# Remove debug include
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Copy copright information
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libzip RENAME copyright)

vcpkg_copy_pdbs()
