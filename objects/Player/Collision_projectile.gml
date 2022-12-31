if other.object_index == ToxicGas && !cantoxic exit

with other {
    if hit_id < 0 {
        hit_id = -1
    }
}

if !inframes && other.team != team && other.hit_id > 0 {
    last_hit = other.hit_id
}