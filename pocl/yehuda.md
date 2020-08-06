for openCL implementation and how to add new device see
http://portablecl.org/
you can donwload it with 
> git clone https://github.com/pocl/pocl.git

I have installation of clang binaries with the next command :
> sudo apt-get install cmake g++ make libxml2-dev libz-dev ninja-build python3-dev swig
For installing latest LLVM (version 10 as of May 2020), run the following convenience script:
> sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

The script will identify the Linux distribution and automatically install latest LLVM.
Specifically, the following tools are installed: clang, lldb, lld, and of course the LLVM library.
After installing LLVM, let clang, lld and lldb point to the new versions:
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 1000 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-10
sudo update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-10 1000
sudo update-alternatives --install /usr/bin/lld lld /usr/bin/lld-10 1000

compileing the project requires building llvm from llvm source code and copy the
llvm include folder from the llvm installation folder -> to pocl include folder.
> cp -rf <path to llvm installation folder>/include/*  ../../include/
> for example:
> cp -rf /nb-llvm/build-inst/include/*  ../../include/

than need to check which version of llvm you copied. in some cases you will have to manually disable
clang version from _libclang_version_checks.h file. it is better to try and build the project and 
see the errors by running the next commands:
> mkdir -p build/Debug
> cd build/Debug
> cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_LLVM_CONFIG=/usr/bin/llvm-config-10 -DCMAKE_CXX_COMPILER=clang++-10  -DCMAKE_C_COMPILER=clang-10    ../..
> make