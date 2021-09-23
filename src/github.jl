
export github_raw


"""
    github_raw(::URI)
Given a GitHub repository URI, return a URI for raw file
access on `master`."
"""
function github_raw(uri::URI)::URI
    @assert uri.host == "github.com"
    split = URIs.splitpath(uri)
    @assert length(split) == 2
    user = split[1]
    repo = split[2]
    URI(;
        scheme="https",
        host="raw.githubusercontent.com",
        path="/$user/$repo/master")
end
