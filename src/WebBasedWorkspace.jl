module WebBasedWorkspace

using HTTP
using Pkg
using TOML
using URIs

include("utils.jl")
include("package_specs.jl")
include("github.jl")

end
