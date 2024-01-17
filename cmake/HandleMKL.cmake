###############################################################################
# Find MKL
find_package(MKL)

if(MKL_FOUND AND GTSAM_WITH_EIGEN_MKL)
    set(GTSAM_USE_EIGEN_MKL 1) # This will go into config.h
    set(EIGEN_USE_MKL_ALL 1) # This will go into config.h - it makes Eigen use MKL
    if(DEFINED VCPKG_INSTALLED_DIR)
        get_target_property(MKL_LIBS MKL::MKL INTERFACE_LINK_LIBRARIES)
        list(APPEND GTSAM_ADDITIONAL_LIBRARIES ${MKL_LIBS})
    else()
    list(APPEND GTSAM_ADDITIONAL_LIBRARIES ${MKL_LIBRARIES})
    endif()

    # --no-as-needed is required with gcc according to the MKL link advisor
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--no-as-needed")
    endif()
else()
    set(GTSAM_USE_EIGEN_MKL 0)
    set(EIGEN_USE_MKL_ALL 0)
endif()
