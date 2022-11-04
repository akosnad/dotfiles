alias -g vim='nvim'
alias n=ninja

function cm(){
    if pwd | grep -vqE "/build$"; then
        if [ ! -f CMakeLists.txt ]; then
            echo not a cmake project!
            return
        fi

        if [ ! -d build ]; then mkdir build; fi
        cd build
    fi
    cmake .. -DCMAKE_BUILD_TYPE=Debug -G Ninja -D "CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -fdiagnostics-color=always" $*
}
