# - Find a osgBullet installation or build tree.
# The following variables are set if osgBullet is found.  If osgBullet is not
# found, osgBullet_FOUND is set to false.
#  osgBullet_FOUND         - Set to true when osgBullet is found.
#  osgBullet_INCLUDE_DIRS  - Include directories for osgBullet
#  osgBullet_LIBRARY_DIRS  - Link directories for osgBullet libraries

# TODO: use Version.h header file and figure out exact version


set(osgBullet_FOUND false)

find_path(
	osgBullet_INCLUDE_DIRS
		osgbCollision/Version.h
	PATH_SUFFIXES
		include
	PATHS
		/usr
		/usr/local
)

set(osgBullet_Components osgbCollision osgbInteraction osgbDynamics)

foreach(component ${osgBullet_Components})
	find_library(
		osgBullet_${component}_LIB
			${component}
		PATH_SUFFIXES
			lib
			lib64
		PATHS
			/usr
			/usr/local
	)
	if(osgBullet_${component}_LIB)
		list(APPEND osgBullet_LIBRARY_DIRS ${osgBullet_${component}_LIB})
	else()
		message(FATAL_ERROR "osgBullet: Unable to find ${component}")
	endif()
	#Clear out the variable so it doesn't show up in CMake
	unset(osgBullet_${component}_LIB CACHE)
endforeach()


if( NOT osgBullet_INCLUDE_DIRS OR NOT osgBullet_LIBRARY_DIRS )
	message(FATAL_ERROR "osgbullet not found.")
else()
	set(osgBullet_FOUND true)
	message(STATUS "osgbullet found: ${osgBullet_INCLUDE_DIRS}")
	message(STATUS "osgbullet libraries: ${osgBullet_LIBRARY_DIRS}") #Figure out why this variable doesn't show up in CMake GUI
endif()
