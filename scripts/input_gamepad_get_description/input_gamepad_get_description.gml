/// @param gamepadIndex

function input_gamepad_get_description(_index)
{
    if (_index < 0) return "Unknown";
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return "Unknown";
    return _gamepad.description;
}