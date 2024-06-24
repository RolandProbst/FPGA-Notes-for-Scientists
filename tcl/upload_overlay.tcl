#############################
# PARAMETERS
#############################
set ip 192.168.2.4
set user xilinx
#############################
cd [get_property DIRECTORY [current_project]]
set projName [get_property NAME [current_project]]
set topDesignName [string map {"_wrapper" ""} [get_property top [current_fileset]]]
set overlay_dir overlay/$projName
file delete -force $overlay_dir
file mkdir $overlay_dir
puts $overlay_dir
file copy -force [glob $projName.runs/impl_1/*.bit] $overlay_dir/$projName.bit
file copy -force [glob $projName.*/sources_1/bd/$topDesignName/hw_handoff/*.hwh] $overlay_dir/$projName.hwh
write_bd_tcl -force $overlay_dir/$projName.tcl
exec scp -r $overlay_dir $user@$ip:/home/xilinx/pynq/overlays
puts "\nOverlay \"$projName\" successfully uploaded to: \n$user@$ip:/home/xilinx/pynq/overlays/$projName"
