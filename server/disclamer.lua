-- Display a fancy message in the server console after the server has fully started

Citizen.CreateThread(function()
    -- Wait for the server to fully start (adjust the time according to your server's startup time)
    Citizen.Wait(60000) -- Wait for 5 seconds (5000 milliseconds) - you may need to adjust this based on your server's startup time

    -- ASCII art for Discord Ballistic Hosting
    local asciiArt = [[
  ____        _ _ _     _   _        _    _           _   _             
 |  _ \      | | (_)   | | (_)      | |  | |         | | (_)            
 | |_) | __ _| | |_ ___| |_ _  ___  | |__| | ___  ___| |_ _ _ __   __ _ 
 |  _ < / _` | | | / __| __| |/ __| |  __  |/ _ \/ __| __| | '_ \ / _` |
 | |_) | (_| | | | \__ \ |_| | (__  | |  | | (_) \__ \ |_| | | | | (_| |
 |____/ \__,_|_|_|_|___/\__|_|\___| |_|  |_|\___/|___/\__|_|_| |_|\__, |
                                                                   __/ |
                                                                  |___/ 
]]

    -- Print the ASCII art and server information
    print(asciiArt)
    print("^3This server is hosted on a free host where the host provider has control over what happens.")
    print("^3While it's free and using bandwidth, the host technically does not need to provide a valid reason for their actions.")
    print("^3Thank you for playing on our server!")

    -- Add any additional information or ASCII art as needed
end)
