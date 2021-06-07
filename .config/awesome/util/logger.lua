local naughty = require("naughty")

local logger = {}


function logger.log(s)
    naughty.notify({
        title = "Info",
        text = tostring(s)
    })
end

function logger.log_error(s)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Error",
        text = tostring(s)
    })
end

return logger
