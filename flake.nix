{
  inputs = {
    openwrt-imagebuilder.url = "github:astro/nix-openwrt-imagebuilder";
  };
  outputs = { self, nixpkgs, openwrt-imagebuilder }: {
    packages.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        profiles = openwrt-imagebuilder.lib.profiles { inherit pkgs; };

        config = profiles.identifyProfile "asus_tuf-ax4200" // {
          packages = [ "umdns" "luci" "luci-app-firewall" "luci-app-sqm" "sqm-scripts" "luci-proto-wireguard" "pbr" "luci-app-pbr" "dnsmasq" ];
        };
      in
      openwrt-imagebuilder.lib.build config;
  };
}
