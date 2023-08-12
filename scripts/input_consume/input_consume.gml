/// @param verb
/// @param [playerIndex]

function input_consume()
{
    var _verb         = argument[0];
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
    
    if (_verb == all)
    {
        var _verb_names = variable_struct_get_names(global.__input_players[_player_index].verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            input_consume(_verb_names[_v], _player_index);
            ++_v;
        }
    }
    else
    {
        var _verb_struct = variable_struct_get(global.__input_players[_player_index].verbs, _verb);
        if (!is_struct(_verb_struct))
        {
            __input_error("Verb not recognised (", _verb, ")");
            return undefined;
        }
        
        with(_verb_struct)
        {
            consumed      = true;
            previous_held = true; //Force the held state on to avoid unwanted early reset of a consumed verb
        }
    }
}