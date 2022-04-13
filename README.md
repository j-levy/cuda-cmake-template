## A template to create cuda programs

0. Set project name in `CMakeLists.txt` (replace "PROJECTNAME")
1. code in `src`
2. add your cpp/cu files in `src/CMakeLists.txt`
3. run the build thing as usual with cmake

On Linux:

```bash
mkdir build
cd build
cmake ..
make -j6
```

Binary is in `bin/projetname-semver/`

On Windows: you should be able to compile with Visual Studio 2019, 2022 and up with Visual Studio CMake support.
