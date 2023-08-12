/// @param verb/array
/// @param [playerIndex]

function input_is_analogue()
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
    
    if (is_array(_verb))
    {
        var _i = 0;
        repeat(array_length(_verb))
        {
            if (input_is_analogue(_verb[_i], _player_index)) return true;
            ++_i;
        }
        
        return false;
    }
    
    var _verb_struct = variable_struct_get(global.__input_players[_player_index].verbs, _verb);
    if (!is_struct(_verb_struct))
    {
        __input_error("Verb not recognised (", _verb, ")");
        return undefined;
    }
    
    return _verb_struct.analogue;
}