{ theme }:
{ pkgs, ... }:
{
  programs = {
    helix = {
      enable = true;
      settings = {
        inherit theme;
        editor = {
          bufferline = "multiple";
          color-modes = true;
          cursorline = true;
          cursor-shape.insert = "bar";
          file-picker.hidden = false;
          indent-guides.render = true;
          line-number = "relative";
          lsp.display-messages = true;
          rulers = [ 80 ];
          scrolloff = 0;
          soft-wrap.enable = true;
          statusline.right = [
            "diagnostics" "separator" "register"
            "selections" "primary-selection-length" "separator"
            "position" "total-line-numbers" "position-percentage" "file-encoding"
          ];
          statusline.left = [ "mode" "spinner" "version-control" "file-name" ];
          whitespace.render = "all";
        };
        keys = {
          insert = {
            j.j = "normal_mode";
          };
          normal = {
            space.q.q = ":quit";
            space.q.Q = ":quit!";
            space.q.a = ":quit-all";
            space.q.A = ":quit-all!";
            space.q.x = ":write-quit-all";
            space.q.X = ":write-quit-all!";
            space.b.b = "buffer_picker";
            space."," = "buffer_picker";
            space.b.k = ":buffer-close";
            space.b.K = ":buffer-close!";
            space.b.N = ":new";
            space.b.o = ":buffer-close-others";
            space.b.O = ":buffer-close-others!";
            space.b.s = ":write";
            space.b.S = ":write-all";
            space.f.e = ":reload";
            space.f.E = ":reload-all";
            space.f.f = "file_picker";
            space.f.F = "file_picker_in_current_buffer_directory";
            space.f.s = ":write";
            space.space = "file_picker_in_current_directory";
            space.w.c = "wclose";
            space.c = "toggle_comments";
            space.m.i = ":toggle-option lsp.display-inlay-hints";
            space.m.f = ":pipe pnpm exec prettier --parser typescript";
            space.m.r = ":reflow 80";
            "C-/" = "toggle_comments";
            "A-/" = "toggle_comments";
            Z.Z = ":write-quit";
            "H" = "goto_window_top";
            "M" = "goto_window_center";
            "L" = "goto_window_bottom";
            "G" = "goto_last_line";
            "ret" = ["move_line_down" "goto_first_nonwhitespace"];
            "minus" = ["move_line_up" "goto_first_nonwhitespace"];
            "{" = "goto_prev_paragraph";
            "}" = "goto_next_paragraph";
          };
        };
      };
      languages = {
        language-server = {
          eslint = {
            command = "eslint";
            args = ["--stdio"];
            config = {
              experimental = { useFlatConfig = false; };
              format = false;
              onIgnoredFiles = "off";
              problems = { shortenToSingleLine = false; };
              quiet = false;
              rulesCustomizations = [];
              # "onType" or "onSave"
              run = "onType";
              # Commenting out this line causes the language-server to crash
              nodePath = "";
              # The documentation says this is "legacy", but without it it doesn't work
              validate = "probe";
              # or [{ mode = "auto" }]
              workingDirectories = [{ mode = "location"; }];
              codeAction = {
                disableRuleComment = { enable = true; location = "separateLine"; };
                showDocumentation = { enable = true; };
              };
            };
          };
          nimlsp = {
            command = "nimlsp";
          };
          nil = {
            command = "nil";
          };
          unison = {
            command = "nc";
            args = ["localhost" "5757"];
          };
          # TODO TS split to efm and ts lang server
        };
        language = [
          {
            name = "typescript";
            language-servers = [ "typescript-language-server" "eslint" ];
            formatter = { command = "pnpm"; args = [ "exec" "prettier" "--parser" "typescript" ]; };
            auto-format = true;
          }
          {
            name = "nim";
            language-servers = ["nimlsp"];
          }
          {
            name = "nix";
            language-servers = ["nil"];
          }
          {
            name = "unison";
            scope = "source.unison";
            "injection-regex" = "unison";
            "file-types" = ["u"];
            shebangs = [];
            roots = [];
            "auto-format" = false;
            "comment-token" = "--";
            indent = { "tab-width" = 4; unit = "    "; };
            language-servers = ["unison"];
          }
        ];
      };
    };
  };
}
