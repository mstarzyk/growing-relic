@test "nginx 1.18.0 is installed" {
    run nginx -V
    [ "${status}" -eq 0 ]
    [[ "${output}" =~ "nginx version: nginx/1.18.0" ]]
}

@test "ruby 2.7.6 is installed" {
    run ruby --version
    [ "${status}" -eq 0 ]
    [[ "${output}" =~ "ruby 2.7.6" ]]
}

@test "puma 5.6.4 is installed" {
    run puma --version
    [ "${status}" -eq 0 ]
    [ "${output}" == "puma version 5.6.4" ]
}
