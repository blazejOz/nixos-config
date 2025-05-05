{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
            #package = config.boot.kernelPackages.nvidiaPackages.latest;
            nvidiaSettings = true;
	          open = true;
  }; 

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  }; 
  
   environment.systemPackages = with pkgs; [
    nvitop #CPU and GPU monitor
  ];
  
  boot.extraModprobeConfig = lib.concatStringsSep "\n" [
    # NVIDIA driver tweaks
    "options nvidia NVreg_PreserveVideoMemoryAllocations=1"
    "options nvidia NVreg_EnableGpuRecovery=1"
    "options nvidia NVreg_TemporaryFilePath=/tmp"
    "options nvidia NVreg_EnableGpuI2C=0"

    # Silence the USB-C CCG driver if unused
    "blacklist ucsi_ccg"

    # Prevent the in-kernel Realtek driver from grabbing your NIC
    "blacklist r8169"
  ];

  boot.kernelParams = [
    "resume=/dev/disk/by-uuid/0e875888-4c63-4731-93e9-fb5949292f99"
    "nvidia-drm.modeset=1"
  ];

systemd.services.reload-nvidia-modules = {
  description = "Reload NVIDIA kernel modules after resume";
  after     = [ "suspend.target" ];
  wantedBy  = [ "suspend.target" ];

  serviceConfig = {
    Type      = "oneshot";
    ExecStart = ''
      modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia || true
      modprobe nvidia
    '';
  };
};



}


