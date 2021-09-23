
"""
    uri_add_path(::URI, ::String...)
Return a new `URI` with the original path extended by the
specified additional components.
"""
function uri_add_path(uri::URI, subs::String...)::URI
    path = ["", URIs.splitpath(uri)..., subs...]
    URI(uri; path=join(path, "/"))
end

"""
    fetch_toml(::URI)
Fetch the contents of the specified `URI` and parse it as TOML.
"""
function fetch_toml(uri::URI)
    response = HTTP.request("GET", uri)
    @assert response.status == 200
    TOML.parse(String(response.body))
end
