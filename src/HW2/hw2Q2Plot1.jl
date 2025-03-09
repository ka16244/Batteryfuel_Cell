# load in some dependency packages
using DelimitedFiles
using Statistics
using ElectrochemicalKinetics
α = 0.5
# α = [0.5, 0.3, 0.1];
j₀ = 1
ΔV = collect(-0.1:0.01:0.1)
bv = ButlerVolmer(j₀,α)

# iF = bv.(ΔV) # full cell 
# ic = bv.(ΔV, true) # Cathodic current 
# ia = iF - ic # anodic current 


iF = bv.(ΔV) # Cathodic current 
ia = bv.(ΔV, true) # anodic current 
ic = iF - ia # full cell 

using Plots
pyplot()
# gr()
# ΔV: Potential [V]
# ia: Anodic current density [mAcm⁻²]
# ic: Cathodic current density [mAcm⁻²]
# iF: Total current density [mAcm⁻²]

# Create the plot  
plot(ΔV, ia, 
    label="jₐ", 
    color="red",
    # color="blue", 
    xlabel="Potential [V]", 
    ylabel="Current density j [mAcm⁻²]",
    legend=:topleft, # Adjust the legend position as needed
    linewidth=2
)

plot!(ΔV, ic, 
    label="jc", 
    color="blue", 
    linewidth=2
)

plot!(ΔV, iF, 
    label="j", 
    color="black", 
    linewidth=2
)

# Add a horizontal line at j = 0
hline!([0], linestyle=:dash, color="black", label="") # remove the line label
#Add a vertical line at V = 0
vline!([0], linestyle=:dash, color="black", label="")
# Set axis limits (optional, based on the image)
xlims!(-0.1, 0.1)
ylims!(-8, 8)
# Display the plot
display(plot!())
