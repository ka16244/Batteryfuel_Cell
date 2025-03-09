# load in some dependency packages
using DelimitedFiles
using Statistics
using ElectrochemicalKinetics
# α = 0.5
α = [0.5, 0.3, 0.1];
j₀ = 1
ΔV = collect(-0.1:0.01:0.1)
bv1 = ButlerVolmer(j₀,α[1])
bv2 = ButlerVolmer(j₀,α[2])
bv3 = ButlerVolmer(j₀,α[3])

#First value of α
iF1 = bv1.(ΔV) # full cell 
ia1 = bv1.(ΔV,true) # Cathodic current 
ic1 = iF1 - ia1 # anodic current 

#Second value of α
iF2 = bv2.(ΔV) # full cell 
ia2 = bv2.(ΔV,true) # Cathodic current 
ic2 = iF2 - ia2 # anodic current

#Third value of α
iF3 = bv3.(ΔV) # full cell 
ia3 = bv3.(ΔV,true) # Cathodic current 
ic3 = iF3 - ia3 # anodic current 

using Plots
pyplot()
# gr()
# ΔV: Potential [V]
# ia: Anodic current density [mAcm⁻²]
# ic: Cathodic current density [mAcm⁻²]
# iF: Total current density [mAcm⁻²]

# Convert current densities to absolute values for log plotting
# abs_ia = abs.(ia)
# abs_ic = abs.(ic)
abs_iF1 = abs.(iF1)
abs_iF2 = abs.(iF2)
abs_iF3 = abs.(iF3)

# cd1 = findall(abs_ia1.>0) #remove all zero values
# cd2 = findall(abs_ia2.>0) #remove all zero values
# cd3 = findall(abs_ia3.>0) #remove all zero values

#create log Plots
plot(ΔV, abs_iF1/1000, yscale=:log10,
    label="α = 0.5", 
    color="black", 
    xlabel="Potential [V]", 
    ylabel="Log (Current density j [Acm⁻²]",
    yticks=(ytick_positions, ytick_labels),
    legend=:top, # Adjust the legend position as needed
    linestyle=:solid,
    linewidth=2
)
plot!(ΔV, abs_iF2/1000,yscale=:log10,
    label="α = 0.3", 
    color="black", 
    xlabel="Potential [V]", 
    ylabel="Log (Current density j [Acm⁻²]",
    yticks=(ytick_positions, ytick_labels),
    legend=:top, # Adjust the legend position as needed
    linestyle=:dot,
    linewidth=2
)
plot!(ΔV,abs_iF3/1000,yscale=:log10,
    label="α = 0.1", 
    color="black", 
    xlabel="Potential [V]", 
    ylabel="Log (Current density j [Acm⁻²]",
    yticks=(ytick_positions, ytick_labels),
    legend=:top, # Adjust the legend position as needed
    linestyle=:dash,
    linewidth=2
)

ytick_positions = [10^-4.5, 10^-4.0, 10^-3.5, 10^-3.0, 10^-2.5, 10^-2.0,10^-1.5]
ytick_labels = ["-4.5", "-4.0", "-3.5", "-3.0", "-2.5", "-2.0", "-1.5"]

xlims!(-0.105, 0.105)
ylims!(10^-4.5, 10^-1.5)
# ylims!(-4.5, -1.5)
# Display the plot
display(plot!())
