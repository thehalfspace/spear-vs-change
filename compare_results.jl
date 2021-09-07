using DelimitedFiles

include("$(@__DIR__)/post/event_details.jl")
include("$(@__DIR__)/post/plotting_script.jl")
include("$(@__DIR__)/post/compare_plots.jl")
include("$(@__DIR__)/post/vs_change_scripts.jl")
include("$(@__DIR__)/post/output_seismograms.jl")

# path to save files
global path = "$(@__DIR__)/plots/vs_damage_comp/"
mkpath(path)

global out_path1 = "$(@__DIR__)/data/vs_damage_01/"
global out_path2 = "$(@__DIR__)/data/vs_damage_02/"
global out_path3 = "$(@__DIR__)/data/vs_damage_03/"
global out_path4 = "$(@__DIR__)/data/vs_damage_04/"
global out_path6 = "$(@__DIR__)/data/vs_damage_06/"

# Global variables
yr2sec = 365*24*60*60

# Order of storage: Seff, tauo, FltX, cca, ccb, xLf
params = readdlm(string(out_path4, "params.out"), header=false)

Seff = params[1,:]
tauo = params[2,:]
FltX = params[3,:]
cca = params[4,:]
ccb = params[5,:]
Lc = params[6,:]

# Index of fault from 0 to 18 km
flt18k = findall(FltX .<= 18)[1]

time_vel1 = readdlm(string(out_path1, "time_velocity.out"), header=false)
t1 = time_vel1[:,1]
Vfmax1 = time_vel1[:,2]
Vsurface1 = time_vel1[:,3]
alphaa1 = time_vel1[:,4]

time_vel2 = readdlm(string(out_path2, "time_velocity.out"), header=false)
t2 = time_vel2[:,1]
Vfmax2 = time_vel2[:,2]
Vsurface2 = time_vel2[:,3]
alphaa2 = time_vel2[:,4]

time_vel3 = readdlm(string(out_path3, "time_velocity.out"), header=false)
t3 = time_vel3[:,1]
Vfmax3 = time_vel3[:,2]
Vsurface3 = time_vel3[:,3]
alphaa3 = time_vel3[:,4]

time_vel4 = readdlm(string(out_path4, "time_velocity.out"), header=false)
t4 = time_vel4[:,1]
Vfmax4 = time_vel4[:,2]
Vsurface4 = time_vel4[:,3]
alphaa4 = time_vel4[:,4]

time_vel6 = readdlm(string(out_path6, "time_velocity.out"), header=false)
t6 = time_vel6[:,1]
Vfmax6 = time_vel6[:,2]
Vsurface6 = time_vel6[:,3]
alphaa6 = time_vel6[:,4]

event_time1 = readdlm(string(out_path1, "event_time.out"), header=false)
tStart1 = event_time1[:,1]
tEnd1 = event_time1[:,2]
hypo1 = event_time1[:,3]

event_time2 = readdlm(string(out_path2, "event_time.out"), header=false)
tStart2 = event_time2[:,1]
tEnd2 = event_time2[:,2]
hypo2 = event_time2[:,3]

event_time3 = readdlm(string(out_path3, "event_time.out"), header=false)
tStart3 = event_time3[:,1]
tEnd3 = event_time3[:,2]
hypo3 = event_time3[:,3]

event_time4 = readdlm(string(out_path4, "event_time.out"), header=false)
tStart4 = event_time4[:,1]
tEnd4 = event_time4[:,2]
hypo4 = event_time4[:,3]

event_time6 = readdlm(string(out_path6, "event_time.out"), header=false)
tStart6 = event_time6[:,1]
tEnd6 = event_time6[:,2]
hypo6 = event_time6[:,3]