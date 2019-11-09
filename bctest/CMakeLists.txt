cmake_minimum_required(VERSION 3.9)

project(bctest CXX)

find_package(Boost REQUIRED COMPONENTS context unit_test_framework)

set(CompilerFlags
        CMAKE_CXX_FLAGS
        CMAKE_CXX_FLAGS_DEBUG
        CMAKE_CXX_FLAGS_RELEASE
        CMAKE_C_FLAGS
        CMAKE_C_FLAGS_DEBUG
        CMAKE_C_FLAGS_RELEASE
        )
foreach(CompilerFlag ${CompilerFlags})
  string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
  string(REPLACE "/MDd" "/MTd" ${CompilerFlag} "${${CompilerFlag}}")
  string(REPLACE "/EHsc" "" ${CompilerFlag} "${${CompilerFlag}}")
endforeach()

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHs")

add_compile_options(/MT$<$<CONFIG:Debug>:d>)
add_executable(test_fcontext test_fcontext.cpp)
target_link_libraries(test_fcontext PRIVATE ${Boost_LIBRARIES})
target_include_directories(test_fcontext PRIVATE ${Boost_INCLUDE_DIRS})

add_compile_options(/MT$<$<CONFIG:Debug>:d>)

set_target_properties(test_fcontext PROPERTIES
    LINK_FLAGS /SUBSYSTEM:CONSOLE
)
