## A template to create cuda programs

Best with Visual Studio Code.

### Configure Visual Studio Code

Download extensions for Visual Studio Code:

- C/C++ (Microsoft)
- CMake Tools (Microsoft)
- CMake (twxs)
- Nsight Visual Studio Code Edition (NVIDIA)

### Configure and run the cmake

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

Binary is in `bin/my_project_name-[semantic-versionning]/`

On Windows: you should be able to compile with Visual Studio 2019, 2022 and up with Visual Studio CMake support.

### Adapt to your program

- in CMakeLists.txt : change `my_project_name` (line 7). You can add more dependencies with the `find_package` command, and change the versioning numbers `NGM_VERSION_[MAJOR, MINOR, BUILD]`.
- in src/CMakeLists.txt : add your source files under `add_executable`, and change the name (for example `cuda_executable_name`). There are 2 executables defined in this example, you can remove the 2nd if you only need a single executable. There are many flags that you can add or change, a basic example (-G) is shown for both C++ and CUDA compilation.


