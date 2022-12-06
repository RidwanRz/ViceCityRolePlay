// ------------------------------------------------------------------------------------------------
srand((GetTickCount() % time()) / 3);

// ------------------------------------------------------------------------------------------------
_Timer <- {
    // --------------------------------------------------------------------------------------------
    m__Timers = { /* ... */ }

    // --------------------------------------------------------------------------------------------
    function Create(environment, listener, interval, repeat, ...)
    {
        // ----------------------------------------------------------------------------------------
        // Prepare the arguments pack
        vargv.insert(0, environment);
        // ----------------------------------------------------------------------------------------
        // Store timer information into a table
        local data = {
            Environment = environment,
            Listener = listener,
            Interval = interval,
            Repeat = repeat,
            Timer = null,
            Args = vargv
        };
        // ----------------------------------------------------------------------------------------
        local hash = split(data+"", ":")[1].slice(3, -1).tointeger(16);
        // ----------------------------------------------------------------------------------------
        // Create the timer instance
        data.Timer = NewTimer("tm_TimerProcess", interval, repeat, hash);
        // ----------------------------------------------------------------------------------------
        // Store the timer information
        m__Timers.rawset(hash, data);
        // ----------------------------------------------------------------------------------------
        // Return the hash that identifies this timer
        return hash;
    }

    // --------------------------------------------------------------------------------------------
    function Destroy(hash)
    {
        // See if the specified timer exists
        if (m__Timers.rawin(hash))
        {
            // Destroy the timer instance
            m__Timers.rawget(hash).Timer.Delete();
            // Remove the timer information
            m__Timers.rawdelete(hash);
        }
    }

    // --------------------------------------------------------------------------------------------
    function Exists(hash)
    {
        // See if the specified timer exists
        return m__Timers.rawin(hash);
    }

    // --------------------------------------------------------------------------------------------
    function Fetch(hash)
    {
        // Return the timer information
        return m__Timers.rawget(hash);
    }

    // --------------------------------------------------------------------------------------------
    function Clear()
    {
        // Process all existing timers
        foreach (tm in m__Timers)
        {
            // Destroy the timer instance
            tm.Timer.Delete();
        }
        // Clear existing timers
        m__Timers.clear();
    }
}

// ------------------------------------------------------------------------------------------------
tm_TimerProcess <- function(hash)
{
    // See if the specified timer exists
    if (_Timer.m__Timers.rawin(hash))
    {
        // Get the timer associated with the specified hash
        local tm = _Timer.m__Timers.rawget(hash);
        // Call the specified listener
        tm.Listener.pacall(tm.Args);
        // Calculate the remaining cycles
        if (tm.Repeat && (--tm.Repeat <= 0))
        {
            // Release the timer
            _Timer.Destroy(hash);
        }
    }
}