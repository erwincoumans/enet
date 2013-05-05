
  solution "0MySolution"

	-- Multithreaded compiling
	if _ACTION == "vs2010" or _ACTION=="vs2008" then
		buildoptions { "/MP"  }
	end 
	
	act = ""
    
    if _ACTION then
        act = _ACTION
    end


	newoption 
	{
    		trigger     = "ios",
    		description = "Enable iOS target (requires xcode4)"
  	}
	
	newoption
	{
		trigger = "bullet2gpu",
		description = "Enable Bullet 2.x GPU using b3GpuDynamicsWorld bridge to Bullet 3.x"
	}

	newoption
	{
		trigger = "enet",
		description = "Enable enet NAT punchthrough test"
	}
  
	configurations {"Release", "Debug"}
	configuration "Release"
		flags { "Optimize", "EnableSSE","StaticRuntime", "NoMinimalRebuild", "FloatFast"}
	configuration "Debug"
		defines {"_DEBUG=1"}
		flags { "Symbols", "StaticRuntime" , "NoMinimalRebuild", "NoEditAndContinue" ,"FloatFast"}
		
	if os.is("Linux") then
		if os.is64bit() then
			platforms {"x64"}
		else
			platforms {"x32"}
		end
	else
		platforms {"x32", "x64"}
	end

	configuration {"x32"}
		targetsuffix ("_" .. act)
	configuration "x64"		
		targetsuffix ("_" .. act .. "_64" )
	configuration {"x64", "debug"}
		targetsuffix ("_" .. act .. "_x64_debug")
	configuration {"x64", "release"}
		targetsuffix ("_" .. act .. "_x64_release" )
	configuration {"x32", "debug"}
		targetsuffix ("_" .. act .. "_debug" )
	
	configuration{}

	postfix=""

	if _ACTION == "xcode4" then
		if _OPTIONS["ios"] then
      			postfix = "ios";
      			xcodebuildsettings
      			{
              		'CODE_SIGN_IDENTITY = "iPhone Developer"',
              		"SDKROOT = iphoneos",
              		'ARCHS = "armv7"',
              		'TARGETED_DEVICE_FAMILY = "1,2"',
              		'VALID_ARCHS = "armv7"',
      			}      
      		else
      			xcodebuildsettings
      			{
              		'ARCHS = "$(ARCHS_STANDARD_32_BIT) $(ARCHS_STANDARD_64_BIT)"',
              		'VALID_ARCHS = "x86_64 i386"',
      			}
    		end
	end

	
	flags { "NoRTTI", "NoExceptions"}
	defines { "_HAS_EXCEPTIONS=0" }
	targetdir "../bin"
	location("./" .. act .. postfix)

	
	projectRootDir = os.getcwd() .. "/../"
	print("Project root directroy: " .. projectRootDir);

	dofile ("findOpenCL.lua")
	dofile ("findDirectX11.lua")
	dofile ("findOpenGLGlewGlut.lua")
	
	language "C++"
		
		include "../btgui/enet"
		include "../test/enet/server"
		include "../test/enet/client"
