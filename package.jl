using Pkg

# list of package names
pkg_list = ["Printf", "PyPlot", "LinearAlgebra", "FileIO", "ImageMagick"];

# install/update packages as necessary
for pkg in pkg_list
    if pkg in keys(Pkg.installed())
        Pkg.update(pkg);
        println("$pkg is up-to-date");
    else
        println("installing $pkg");
        Pkg.add(pkg);
        println("$pkg is installed");
    end
end
