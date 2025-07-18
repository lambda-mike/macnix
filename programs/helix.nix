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
            "diagnostics"
            "separator"
            "register"
            "selections"
            "primary-selection-length"
            "separator"
            "position"
            "total-line-numbers"
            "position-percentage"
            "file-encoding"
          ];
          statusline.left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
          ];
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
            space.m.f.c = ":pipe pnpm exec prettier --parser css --loglevel silent";
            space.m.f.h = ":pipe pnpm exec prettier --parser html --loglevel silent";
            space.m.f.s = ":pipe pnpm exec prettier --parser scss --loglevel silent";
            space.m.f.t = ":pipe pnpm exec prettier --parser typescript --loglevel silent";
            space.m.r = ":reflow 80";
            "C-/" = "toggle_comments";
            "A-/" = "toggle_comments";
            Z.Z = ":write-quit";
            "H" = "goto_window_top";
            "M" = "goto_window_center";
            "L" = "goto_window_bottom";
            "G" = "goto_last_line";
            "ret" = [
              "move_line_down"
              "goto_first_nonwhitespace"
            ];
            "minus" = [
              "move_line_up"
              "goto_first_nonwhitespace"
            ];
            "{" = "goto_prev_paragraph";
            "}" = "goto_next_paragraph";
          };
        };
      };
      languages = {
        language-server = {
          eslint = {
            command = "vscode-eslint-language-server";
            args = [ "--stdio" ];
            config = {
              experimental = {
                useFlatConfig = false;
              };
              # onIgnoredFiles = "off";
              problems = {
                shortenToSingleLine = false;
              };
              quiet = false;
              rulesCustomizations = [ ];
              # "onType" or "onSave"
              run = "onType";
              # Commenting out this line causes the language-server to crash
              nodePath = "";
              validate = "on";
              # or [{ mode = "auto" }]
              workingDirectory = {
                mode = "location";
              };
              codeAction = {
                disableRuleComment = {
                  enable = true;
                  location = "separateLine";
                };
                showDocumentation = {
                  enable = true;
                };
              };
              codeActionOnSave = {
                disableRuleComment = {
                  enable = true;
                  mode = "fixAll";
                };
              };
            };
          };
          nimlsp = {
            command = "nimlsp";
          };
          nil = {
            command = "nil";
          };
          "typescript-language-server" = {
            config = {
              documentFormatting = false;
            };
          };
          unison = {
            command = "nc";
            args = [
              "localhost"
              "5757"
            ];
          };
          # TODO TS split to efm and ts lang server
        };
        language = [
          {
            name = "css";
            # using pnpm as runner
            formatter = {
              command = "pnpm";
              args = [
                "exec"
                "prettier"
                "--parser"
                "css"
                "--loglevel"
                "silent"
              ];
            };
            auto-format = true;
          }
          {
            name = "json";
            # using pnpm as runner
            formatter = {
              command = "pnpm";
              args = [
                "exec"
                "prettier"
                "--parser"
                "json"
                "--loglevel"
                "silent"
              ];
            };
            auto-format = true;
          }
          {
            name = "html";
            # using pnpm as runner
            formatter = {
              command = "pnpm";
              args = [
                "exec"
                "prettier"
                "--parser"
                "html"
                "--loglevel"
                "silent"
              ];
            };
            auto-format = true;
          }
          {
            name = "scss";
            # using pnpm as runner
            formatter = {
              command = "pnpm";
              args = [
                "exec"
                "prettier"
                "--parser"
                "scss"
                "--loglevel"
                "silent"
              ];
            };
            auto-format = true;
          }
          {
            name = "typescript";
            language-servers = [
              {
                except-features = [ "format" ];
                name = "typescript-language-server";
              }
              "eslint"
            ];
            formatter = {
              command = "pnpm";
              args = [
                "exec"
                "prettier"
                "--parser"
                "typescript"
                "--loglevel"
                "silent"
              ];
            };
            auto-format = true;
          }
          {
            name = "tsx";
            language-servers = [
              {
                except-features = [ "format" ];
                name = "typescript-language-server";
              }
              "eslint"
            ];
            formatter = {
              command = "pnpm";
              args = [
                "exec"
                "prettier"
                "--parser"
                "typescript"
                "--loglevel"
                "silent"
              ];
            };
            auto-format = true;
          }
          {
            name = "nim";
            language-servers = [ "nimlsp" ];
          }
          {
            name = "nix";
            language-servers = [ "nil" ];
          }
          {
            name = "unison";
            scope = "source.unison";
            "injection-regex" = "unison";
            "file-types" = [ "u" ];
            shebangs = [ ];
            roots = [ ];
            "auto-format" = false;
            "comment-token" = "--";
            indent = {
              "tab-width" = 4;
              unit = "    ";
            };
            language-servers = [ "unison" ];
          }
        ];
      };
    };
  };
}
