## A template to create cuda programs

Best with Visual Studio Code, but you can use this template with the command line too.

### Configure Visual Studio Code

Download extensions for Visual Studio Code:

- C/C++ (Microsoft)
- CMake Tools (Microsoft)
- CMake (twxs)
- Nsight Visual Studio Code Edition (NVIDIA)

### Configure and run the cmake

Before changing this template, make sure it compiles and run correctly

On Linux:

```bash
mkdir build
cd build
cmake ..
make -j6
```

Binary is in `bin/my_project_name-[semantic-versionning]/`

On Windows: you should be able to compile with Visual Studio 2019, 2022 and up with Visual Studio CMake support.

### Compile, run, debug with the Visual Studio Code GUI

- Click the "Build" button at the bottom of the window (in the blue bar). If it asks for a compiler kit, select the one it offers you.

That should be it.

If you want to run the debug command:

- If you want, put some breakpoints in your code (clicking on the left of a line number, that creates a breakpoint with a red dot)
- On the left toolbar, click the Play button with the little bug.
- On the left panel, at the top, select the debug target in the list (for example, select "Debug my cuda executable let's go!")
- Click on the play button next to the list

The code should now run in the cuda-gdb debugger. When it stops, your program state is displayed in the left panel: variables are on the top, stack call is on the bottom.

Debugging configuration is specified in the file `.vscode/launch.json`.

### Adapt to your program

0. Set your project name in `CMakeLists.txt` (replace "my_project_name")
1. put your code in `src` and your headers in `include`
2. add your cpp/cu files in `src/CMakeLists.txt` under the `add_executable` command
3. run the build thing as usual with cmake

With more details:

- in CMakeLists.txt : change `my_project_name` (line 7). You can add more dependencies with the `find_package` command, and change the versioning numbers `NGM_VERSION_[MAJOR, MINOR, BUILD]`.
- in src/CMakeLists.txt : add your source files under `add_executable`, and change the name (for example `cuda_executable_name`). There are 2 executables defined in this example, you can remove the 2nd if you only need a single executable. There are many flags that you can add or change, a basic example (-G) is shown for both C++ and CUDA compilation.
- in .vscode/launch.json, you should the path of your executable for the debugging command to work accordingly.


