using Plots

# Universal Constants
const R = 8.314 # J/(mol*K)
const F = 96485.3 # C/mol

# 1. Solid Oxide Fuel Cell OCV
function nernst_ocv_sofc(T::Float64, pH2::Float64, pO2::Float64, pH2O::Float64)
    # T in Kelvin, pressures in atm
    ΔG0 = -228170 # J/mol at standard conditions
    n = 2 # Number of electrons per H2 molecule
    E0 = -ΔG0 / (n * F) # Standard potential
    OCV = E0 + (R * T / (n * F)) * log(pH2 * sqrt(pO2) / pH2O)
    return OCV
end

# 2. Lithium-Ion Battery OCV
# Sample empirical OCV curves for different chemistries
const OCV_LFP = [0.0 => 2.5, 0.5 => 3.2, 1.0 => 3.6]  # State of charge (SOC) vs OCV (V)
const OCV_NMC = [0.0 => 3.0, 0.5 => 3.7, 1.0 => 4.2]

function interpolate_ocv(soc::Float64, ocv_curve::Vector{Pair{Float64, Float64}})
    socs = [p.first for p in ocv_curve]
    ocvs = [p.second for p in ocv_curve]
    return linear_interpolation(soc, socs, ocvs)
end

function linear_interpolation(x, xs, ys)
    for i in 1:length(xs) - 1
        if x >= xs[i] && x <= xs[i + 1]
            x0, x1 = xs[i], xs[i + 1]
            y0, y1 = ys[i], ys[i + 1]
            return y0 + (x - x0) * (y1 - y0) / (x1 - x0)
        end
    end
    error("SOC out of range")
end
