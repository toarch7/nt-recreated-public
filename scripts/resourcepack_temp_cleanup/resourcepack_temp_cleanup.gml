function resourcepack_temp_cleanup() {
    directory_destroy_recursive(game_save_id + "replacedsprites")
    directory_destroy_recursive(game_save_id + "_install")
    directory_destroy_recursive(game_save_id + "_download")
}