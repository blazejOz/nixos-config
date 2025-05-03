{ config, pkgs, ... }:

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
  
}

