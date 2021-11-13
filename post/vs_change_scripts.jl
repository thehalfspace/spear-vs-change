using PyPlot
using StatsBase
using LaTeXStrings
using PyCall
mpl = pyimport("matplotlib")

# Default plot params
function plot_params()
  plt.rc("xtick", labelsize=16)
  plt.rc("ytick", labelsize=16)
  plt.rc("xtick", direction="in")
  plt.rc("ytick", direction="in")
  plt.rc("font", size=15)
  plt.rc("figure", autolayout="True")
  plt.rc("axes", titlesize=16)
  plt.rc("axes", labelsize=17)
  plt.rc("xtick.major", width=1.5)
  plt.rc("xtick.major", size=5)
  plt.rc("ytick.major", width=1.5)
  plt.rc("ytick.major", size=5)
  plt.rc("lines", linewidth=2)
  plt.rc("axes", linewidth=1.5)
  plt.rc("legend", fontsize=13)
  plt.rc("mathtext", fontset="stix")
  plt.rc("font", family="STIXGeneral")

  # Default width for Nature is 7.2 inches, 
  # height can be anything
  #plt.rc("figure", figsize=(7.2, 4.5))
end

# Plot shear stress comparison
function Vfmax_comp(Vfmax1, Vfmax2, t1, t2, tS1, tS2, tE1, tE2)
    plot_params()
 
	# Without vs change
	idS1 = findmax(t1 .>= tS1[5])[2]
	idE1 = findmax(t1 .>= tE1[5])[2]
	
	# With vs change
	idS2 = findmax(t2 .>= tS2[2])[2]
	idE2 = findmax(t2 .>= tE2[2])[2]	

	# ref is the translation factor to bring both plots to
	# the same zero (in seconds)
	ref = -23.5

    fig = PyPlot.figure(figsize=(7.2, 4.45))
    ax = fig.add_subplot(111)
    ax.plot(t1[idS1:idE1] .- t1[idS1] .- ref, Vfmax1[idS1:idE1], lw = 2.0, color="tab:blue", 
            label="1 km DFZ, 0% vs contrast")
    ax.plot(t2[idS2:idE2] .- t2[idS2], Vfmax2[idS2:idE2], lw = 2.0, color="tab:orange", alpha = 0.9,
            label="1 km DFZ, 1% vs contrast") 
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Max. slip rate (m/s)")
    plt.legend()
    show()
    
    figname = string(path, "VfComp_01.png");
    fig.savefig(figname, dpi = 300);

end


# Plot shear stress comparison
function Vfmax_comp_full(Vfmax1, Vfmax2, t1, t2)
    plot_params()
 
    fig = PyPlot.figure(figsize=(7.2, 4.45))
    ax = fig.add_subplot(111)
    ax.plot(t1, Vfmax1, lw = 2.0, color="tab:blue", 
            label="1 km DFZ, 0% Vs contrast, 1% red.")
   ax.plot(t2, Vfmax2, lw = 2.0, color="tab:orange",
            label="1 km DFZ, 30% Vs contrast, 1% red.") 
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Max. slip rate (m/s)")
	ax.set_yscale("log")
    plt.legend()
    show()
    
    figname = string(path, "Vfmax_comp_full.png");
    fig.savefig(figname, dpi = 300);

end