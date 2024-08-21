{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "jonas";
  home.homeDirectory = "/home/jonas";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    pavucontrol
  ];

  programs = {
    # basic configuration of git, please change to your own
    git = {
      enable = true;
      userName = "Jonas Ingerslev Sørensen";
      userEmail = "ingerslev.jonas@gmail.com";
    };

    # starship - an customizable prompt for any shell
    starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    nushell = {
      enable = true;
    };

    fuzzel = {
      enable = true;
      settings = {
	colors = {
	  background="282a36fa";
	  selection="3d4474fa";
	  border="fffffffa";
	};
      };
    };

  };

  services.hyprpaper = {
    enable = true;
    settings = {
       preload = [
        "/home/jonas/Wallpapers/protos.jpeg"
	"/home/jonas/Wallpapers/terran.jpeg"
	"/home/jonas/Wallpapers/zerg.jpeg"
      ];

      wallpaper = [
        "DP-3, /home/jonas/Wallpapers/protos.jpeg"
	"DP-2, /home/jonas/Wallpapers/terran.jpeg"
	"DP-1, /home/jonas/Wallpapers/zerg.jpeg"      
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = [
	"DP-1, preferred, auto, auto"
	"DP-2, 1920x1080@60, auto, auto"
	"DP-3, preferred, auto, auto"
	",preferred, auto, 1, mirror, DP-2"

      ];

      windowrulev2 = [
        "float, class:^(steam)$"
      ];

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      input = {
        kb_layout = "dk";
      };

      bind =
        [
          "$mod, W, exec, firefox"
          "$mod, T, exec, kitty"
          "$mod, C, killactive"
          "$mod, E, exec, fuzzel"
	  "$mod, F, fullscreen"
	  "$mod, V, togglefloating"

	  "$mod, mouse:272, movewindow"

        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
    };
  };

  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
