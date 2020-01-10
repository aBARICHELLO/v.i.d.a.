workspace "vida"
    configurations { "Debug", "Release" }

local devkitpro = os.getenv("DEVKITPRO")
local devkitarm = os.getenv("DEVKITARM")

project "vida"
    kind "ConsoleApp"
    language "C++"
    targetdir "bin/%{cfg.buildcfg}"

    makesettings [[
        CXX = arm-none-eabi-g++
        LD = arm-none-eabi-g++
    ]]

    files {
        "./src/**.h",
        "./src/**.cpp"
    }

    defines {
        "_3DS",
        "ARM11",
    }

    includedirs {
        "include",
        "include/m3d",
        devkitpro .. "/libctru/include",
        devkitpro .. "/portlibs/3ds/include",
    }

    links {
        "m3dia",
        "citro2d",
        "citro3d",
        "ctru",
    }

    libdirs {
        devkitpro .. "/libctru/lib",
        devkitpro .. "/portlibs/3ds/lib",
    }

    buildoptions {
        "-MMD",
        "-MP",
        "-g",
        "-Wall",
        "-std=gnu++11",
        "-Werror",
        "-mword-relocations",
        "-ffunction-sections",
        "-fno-rtti",
        "-fno-exceptions",
        "-fomit-frame-pointer",
        "-march=armv6k",
        "-mtune=mpcore",
        "-mfloat-abi=hard",
        "-mtp=soft",
    }

    linkoptions {
        "-o vida.3dsx",
        "-specs=3dsx.specs",
        "-march=armv6k",
        "-mtune=mpcore",
        "-mfloat-abi=hard",
        "-mtp=soft",
    }

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "RELEASE" }
        optimize "On"