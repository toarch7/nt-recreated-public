/// @param [array]
/// @param [playerIndex]

function input_check_press_most_recent()
{
    var _verb_names   = ((argument_count > 0) && is_array(argument[0]))? argument[0] : all;
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _verbs_array = global.__input_players[_player_index].verbs;
    if (!is_array(_verb_names)) _verb_names = variable_struct_get_names(_verbs_array);
    
    var _max_time = -1;
    var _max_verb = undefined;
    var _i = 0;
    repeat(array_length(_verb_names))
    {
        var _verb = _verb_names[_i];
        var _verb_struct = variable_struct_get(_verbs_array, _verb);
        
        if ((_verb_struct.press_time > _max_time) && input_check(_verb, _player_index))
        {
            _max_time = _verb_struct.press_time;
            _max_verb = _verb;
        }
        
        ++_i;
    }
    
    return _max_verb;
}