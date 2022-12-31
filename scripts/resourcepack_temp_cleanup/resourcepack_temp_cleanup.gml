function resourcepack_temp_cleanup() {
    directory_destroy_recursive("./replacedsprites")
    directory_destroy_recursive("./_install")
    directory_destroy_recursive("./_download")
}