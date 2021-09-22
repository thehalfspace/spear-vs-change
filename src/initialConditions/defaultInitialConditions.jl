using PyCall
np = pyimport("numpy")

# Linear interpolation function
function Int1D(P1, P2, val)	
	Line = P1[1] .+ ( (P2[1] - P1[1])/((P2[2] - P1[2])).*(val .- P1[2]) )	
	return Line
end


# Compute rate-state friciton with depth
function fricDepth(FltX)
    
    FltNglob = length(FltX)
    
    # Friction with depth
    cca::Array{Float64} = repeat([0.015], FltNglob)
    ccb::Array{Float64} = repeat([0.010], FltNglob)

    a_b = cca - ccb
    fP1 = [0.005, -12]
    fP2 = [-0.005, -10]
    fP3 = [-0.005, 10]
    fP4 = [0.005, 12]

    fric_depth1 = findall((FltX) .<= (fP1[2]))
    fric_depth2 = findall((fP1[2]) .< (FltX) .<= (fP2[2]))
    fric_depth3 = findall((fP2[2]) .< (FltX) .<= (fP3[2]))
    fric_depth4 = findall((fP3[2]) .< (FltX) .<= (fP4[2]))
    fric_depth5 = findall((FltX) .> (fP4[2]))

    a_b[fric_depth1] .= 0.005 
    a_b[fric_depth2] .= Int1D(fP1, fP2, FltX[fric_depth2])
    a_b[fric_depth3] .= -0.005 
    a_b[fric_depth4] .= Int1D(fP3, fP4, FltX[fric_depth4])
    a_b[fric_depth5] .= 0.005
    
    ccb .= cca .- a_b

    return cca, ccb
end



# Effective normal stress
function SeffDepth(FltX)

    FltNglob = length(FltX)

    Seff::Array{Float64} = repeat([10e6], FltNglob)
    # sP1 = [10e6 0]
    # sP2 = [50e6 -2e3]
    # Seff_depth = findall(abs.(FltX) .<= abs(sP2[2]))
    # Seff[Seff_depth] = Int1D(sP1, sP2, FltX[Seff_depth])

    return Seff
end

function stress_amplitude(k, ac, H)
    # Correlation length: ac = 2π/kc
    kc = 2π/ac
    τ_k = zeros(size(k))
    for i in 1:size(k)[1]
        for j in 1:size(k)[2]
            if k[i,j] <= kc
                τ_k[i,j] = kc^(-(1+H))
            else
                τ_k[i,j] = k[i,j]^(-(1+H))  
            end
        end
    end
    return τ_k
end

# Function to generate self-similar Stresses
function self_similar_stress(FltX)
    N = length(FltX)
    # input values
    x = LinRange(0.1,100,N)
    z = LinRange(0.1,100,N)
    kx, kz = np.meshgrid(x, z)

    # random phase values
    ϕ = 100 * rand(length(x), length(x))

    # k = 10 .^(kx.^2 .+ kz.^2 .+ ϕ.^2)
    k = (kx.^2 .+ kz.^2 .+ ϕ.^2) .^ 0.5
    ac = 5e0    # in meters
    H = 1       # Test case
    tau_k = stress_amplitude(k, ac, H)
    tau_x_z = ifft(tau_k)

    r_tau = abs.(tau_x_z)
    r_tau2 = r_tau./maximum(r_tau)
    r_tau3 = r_tau2[:, Int((length(x)+1)/2)]


    return (r_tau3 .- mean(r_tau3)).*5e8

end

# Shear stress
function tauDepth(FltX)

    FltNglob = length(FltX)

    tauo::Array{Float64} = repeat([22e6], FltNglob)
    tP1 = [70e6 -12]
    tP2 = [81e6 -2]
    #  tP2 = [30e6 -0.5e3]
    tP3 = [81e6 2]
    tP4 = [70e6 12]
    # tP5 = [22e6 -24]

    tau_depth1 = findall((FltX) .<= (tP1[2]))
    tau_depth2 = findall((tP1[2]) .< (FltX) .<= (tP2[2]))
    tau_depth3 = findall((tP2[2]) .< (FltX) .<= (tP3[2]))
    tau_depth4 = findall((tP3[2]) .< (FltX) .<= abs(tP4[2]))
    tau_depth5 = findall((FltX) .>= (tP4[2]))

    tauo[tau_depth1] .= 22e6 # Int1D(tP1, tP2, FltX[tau_depth1])
    tauo[tau_depth2] .= Int1D(tP1, tP2, FltX[tau_depth2])
    tauo[tau_depth3] .= 30e6 # Int1D(tP3, tP4, FltX[tau_depth3])
    tauo[tau_depth4] .= Int1D(tP3, tP4, FltX[tau_depth4])
    tauo[tau_depth5] .= 22e6 
    # Self-similar noise in stress
    # std = self_similar_stress(FltX) 

    # return (tauo .+ self_similar_stress(FltX))

    return tauo
end
