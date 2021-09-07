##############################
#  PLOTTING SCRIPTS
##############################

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

# Plot Vfmax
function VfmaxComp(Vf1, t1, Vf2, t2, Vf3, t3, Vf4, t4, Vf5, t5, yr2sec)
    plot_params()
    fig = PyPlot.figure(figsize=(7.2, 3.45))
    ax = fig.add_subplot(111)
    
    ax.plot(t1./yr2sec, Vf1, lw = 2.0, label="Homogeneous")
    ax.plot(t2./yr2sec, Vf2, lw = 2.0, label="2 km DFZ, 1% red.")
    # ax.plot(t3./yr2sec, Vf3, lw = 2.0, label="2 km DFZ, 2% red.")
    # ax.plot(t4./yr2sec, Vf4, lw = 2.0, label="1 km DFZ, 1% red.")
    # ax.plot(t5./yr2sec, Vf5, lw = 2.0, label="1 km DFZ, 2% red.")
    ax.set_xlabel("Time (years)")
    ax.set_ylabel("Max. Slip rate (m/s)")
    ax.set_yscale("log")
    #  ax.set_xlim([230,400])
	ax.legend()
    show()
    
    figname = string(path, "Vfcomp05.png")
    fig.savefig(figname, dpi = 300)
end

function VfEvent(Vf1, t1, Vf2, t2, Vf3, t3, Vf4, t4, Vf5, t5, yr2sec)
    plot_params()
    fig = PyPlot.figure(figsize=(7.2, 3.45))
    ax = fig.add_subplot(111)
    
    ax.plot(t1./yr2sec, Vf1, lw = 2.0, label="Homogeneous")
    ax.plot(t2./yr2sec, Vf2, lw = 2.0, label="2 km DFZ, 1% red.")
    # ax.plot(t3./yr2sec, Vf3, lw = 2.0, label="2 km DFZ, 2% red.")
    # ax.plot(t4./yr2sec, Vf4, lw = 2.0, label="1 km DFZ, 1% red.")
    # ax.plot(t5./yr2sec, Vf5, lw = 2.0, label="1 km DFZ, 2% red.")
    ax.set_xlabel("Time (years)")
    ax.set_ylabel("Max. Slip rate (m/s)")
    ax.set_yscale("log")
    #  ax.set_xlim([230,400])
	ax.legend()
    show()
    
    figname = string(path, "Vfevent01.png")
    fig.savefig(figname, dpi = 300)
end