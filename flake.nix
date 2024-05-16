{
 outputs = {self, nixpkgs,...  }: {
    nixosConfigurations.testvm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
         # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/qemu-vm.nix
         # https://github.com/NixOS/nixpkgs/blob/mastser/nixos/modules/profiles/macos-builder.nix
        {
          virtualisation.vmVariant.virtualisation = {
            host.pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            graphics = false;
            memorySize = 1024 * 8;
            cores = 8;
          };
         }
      ];
    };
   packages.aarch64-darwin.darwinVM = self.nixosConfigurations.testvm.config.system.build.vm;
  };
}
