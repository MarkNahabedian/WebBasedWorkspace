using WebBasedWorkspace
using Test
using URIs
using Pkg

EXAMPLE_URI = URI("https://github.com/MarkNahabedian/WebBasedWorkspace")

@testset "WebBasedWorkspace.jl" begin
    pspecs = package_specs(github_raw(EXAMPLE_URI))
    @test length(pspecs) == 4
    Pkg.add(pspecs)
end

