local logger = require("util/logger")

local error_notifier = {}

function error_notifier.checkStartupErrors()
    -- Checking for errors during startup
    if (awesome.startup_errors) then
        logger.log_error(awesome.startup_errors)
    end
end

function error_notifier.enableErrorNotifications()
    -- Setting up error notifications
    do
        local in_error = false
        awesome.connect_signal("debug::error", function(err)
        
            if (in_error) then return end
            in_error = true

            logger.log_error(tostring(err))

            in_error = false
        end)
    end
end

return error_notifier
