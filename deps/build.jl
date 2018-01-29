using CUDAapi

config_path = joinpath(@__DIR__, "ext.jl")
const previous_config_path = config_path * ".bak"

function write_ext(config)
    open(config_path, "w") do io
        println(io, "# autogenerated file, do not edit")
        for (key,val) in config
            println(io, "const $key = $(repr(val))")
        end
    end
end

function main()
    ispath(config_path) && mv(config_path, previous_config_path; remove_destination=true)
    config = Dict{Symbol,Any}(:configured => false)
    write_ext(config)


    ## discover stuff

    toolkit = CUDAapi.find_toolkit()

    config[:libcublas] = CUDAapi.find_cuda_library("cublas", toolkit)
    config[:libcusolver] = CUDAapi.find_cuda_library("cusolver", toolkit)
    config[:libcufft] = CUDAapi.find_cuda_library("cufft", toolkit)

    config[:libcudnn] = CUDAapi.find_cuda_library("cudnn", toolkit)
    if config[:libcudnn] == nothing
      warn("could not find CUDNN, its functionality will be unavailable")
    end

    ## (re)generate ext.jl

    function globals(mod)
        all_names = names(mod, true)
        filter(name-> !any(name .== [module_name(mod), Symbol("#eval"), :eval]), all_names)
    end

    if isfile(previous_config_path)
        @debug("Checking validity of existing ext.jl...")
        @eval module Previous; include($previous_config_path); end
        previous_config = Dict{Symbol,Any}(name => getfield(Previous, name)
                                           for name in globals(Previous))

        if config == previous_config
            info("CuArrays.jl has already been built for this toolchain, no need to rebuild")
            mv(previous_config_path, config_path; remove_destination=true)
            return
        end
    end

    config[:configured] = true
    write_ext(config)

    return
end

main()
