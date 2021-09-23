
export package_specs


"""
Return a `Vector` of `PackageSpec`s that are needed by the
workspace that's the target of the `URI`."
"""
function package_specs end

function package_specs(string::String)
    add_packages_from(URI(string))
end

function package_specs(uri::URI)
    package_specs = Vector{Pkg.Types.PackageSpec}()
    project = fetch_toml(uri_add_path(uri, "Project.toml"))
    manifest = fetch_toml(uri_add_path(uri, "Manifest.toml"))
    function mfind(name, uuid)
        for (pkg, recs) in manifest
            if name != pkg
                continue
            end
            for rec in recs
                if uuid == rec["uuid"]
                    return rec
                end
            end
        end
        return nothing
    end
    for (name, uuid) in project["deps"]
        rec = mfind(name, uuid)
        if rec == nothing
            throw(ErrorException("Package $name not found in manifest"))
        end
        psargs = Dict(:name => name,
                      :uuid => uuid)
        if haskey(rec, "repo-url")
            psargs[:url] = rec["repo-url"]
        end
        if haskey(rec, "version")
            psargs[:version] = rec["version"]
        end
        
        push!(package_specs,
              PackageSpec(; psargs...))
    end
    package_specs
end
