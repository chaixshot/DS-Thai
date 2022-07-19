-- แปล modinfo.lua
if _G.ModIndex.InitializeModInfoEnv then
    local old_InitializeModInfoEnv = _G.ModIndex.InitializeModInfoEnv
    _G.ModIndex.InitializeModInfoEnv = function(self,...)
        local env = old_InitializeModInfoEnv(self,...)
		env.language = t.SelectedLanguage
		env.thai = true
        return env
    end
else
    local temp_mark = false
    local old_kleiloadlua = _G.kleiloadlua
    _G.kleiloadlua = function(path,...)
        local fn = old_kleiloadlua(path,...)
        if fn and type(fn) ~= "string" and path:sub(-12) == "/modinfo.lua" then
			temp_mark = true
        end
        return fn
    end
   
    local old_RunInEnvironment = _G.RunInEnvironment
    _G.RunInEnvironment = function(fn, env, ...)
		if env and temp_mark then
			env.language = t.SelectedLanguage
			env.thai = true
			temp_mark = false
		end
		return old_RunInEnvironment(fn, env, ...)
    end
end