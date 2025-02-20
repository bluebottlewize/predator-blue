# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/appPredatorBlue_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appPredatorBlue_autogen.dir/ParseCache.txt"
  "appPredatorBlue_autogen"
  )
endif()
