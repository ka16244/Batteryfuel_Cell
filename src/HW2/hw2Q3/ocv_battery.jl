include("NerNest.jl")
# Example Usage
T = 1000.0 # Kelvin
pH2 = 1.0  # atm
pO2 = 0.21 # atm
pH2O = 0.1 # atm

ocv_sofc = nernst_ocv_sofc(T, pH2, pO2, pH2O)
println("SOFC OCV: ", round(ocv_sofc, digits=4), " V")

soc = 0.6; # State of charge (0 to 1)
ocv_lfp = interpolate_ocv(soc, OCV_LFP);
ocv_nmc = interpolate_ocv(soc, OCV_NMC);

println("LFP Battery OCV: ", round(ocv_lfp, digits=4), " V")
println("NMC Battery OCV: ", round(ocv_nmc, digits=4), " V")