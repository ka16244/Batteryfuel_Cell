# load in some dependency packages
using DelimitedFiles
using Statistics
using ElectrochemicalKinetics

# load in some dependency packages
using DelimitedFiles
using Statistics
using ElectrochemicalKinetics
# α = 0.5
α = [0.5, 0.3, 0.1];
j₀ = 1
ΔV = collect(-0.1:0.01:0.1)
bv = ButlerVolmer(j₀,α[3])

iF = bv.(ΔV) # full cell 
ic = bv.(ΔV,true) # Cathodic current 
ia = iF - ic # anodic current 

using Plots
pyplot()
# gr()
# ΔV: Potential [V]
# ia: Anodic current density [mAcm⁻²]
# ic: Cathodic current density [mAcm⁻²]
# iF: Total current density [mAcm⁻²]

# # Create the plot  
# plot(ΔV, ia, 
#     label="jₐ", 
#     color="red", 
#     xlabel="Potential [V]", 
#     ylabel="Current density j [mAcm⁻²]",
#     legend=:topleft, # Adjust the legend position as needed
#     linewidth=2
# )

# plot!(ΔV, ic, 
#     label="jc", 
#     color="blue", 
#     linewidth=2
# )

# plot!(ΔV, iF, 
#     label="j", 
#     color="black", 
#     linewidth=2
# )

# # Add a horizontal line at j = 0
# hline!([0], linestyle=:dash, color="black", label="") # remove the line label
# #Add a vertical line at V = 0
# vline!([0], linestyle=:dash, color="black", label="")
# # Set axis limits (optional, based on the image)
# xlims!(-0.1, 0.1)
# ylims!(-8, 8)
# # Display the plot
# display(plot!())

# Convert current densities to absolute values for log plotting
abs_ia = abs.(ia)
abs_ic = abs.(ic)
abs_iF = abs.(iF)
# Set a reasonable default plot size globally
# default(size=(600, 400))

#create log Plots

# plot(ΔV, abs_ia/1000, yscale=:log10,
#     label="jₐ", 
#     color="red", 
#     xlabel="Potential [V]", 
#     ylabel="Log (Current density j [Acm⁻²]",
#     legend=:topleft, # Adjust the legend position as needed
#     linewidth=2
#     # size=(600, 400) # Set plot size to avoid the zero plot area error
# )

# plot!(ΔV, abs_ic/1000, 
#     label="jc", 
#     color="blue", 
#     linewidth=2
# )
ytick_positions = [10^-4.5, 10^-4.0, 10^-3.5, 10^-3.0, 10^-2.5, 10^-2.0,10^-1.5]
ytick_labels = ["-4.5", "-4.0", "-3.5", "-3.0", "-2.5", "-2.0", "-1.5"]

plot!(ΔV, abs_iF/1000, yscale=:log10,
    label="j", 
    color="black", 
    xlabel="Potential [V]", 
    ylabel="Log (Current density j [Acm⁻²]",
    yticks=(ytick_positions, ytick_labels),
    legend=:top, # Adjust the legend position as needed
    linestyle=:dash,
    linewidth=2
)

# Add a horizontal line at j = 0
# hline!([0], linestyle=:dash, color="black", label="") # remove the line label
#Add a vertical line at V = 0
#  vline!([0], linestyle=:dash, color="black", label="")
# Set axis limits (optional, based on the image)
xlims!(-0.1, 0.1)
ylims!(10^-4.5, 10^-1.5)
# ylims!(-4.5, -1.5)
# Display the plot
display(plot!())
