const std = @import("std");

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const screen = b.addStaticLibrary(.{
        .name = "screen",
        .target = target,
        .optimize = optimize,
    });
    screen.addIncludePath(std.Build.LazyPath{ .path = "src" });
    screen.addIncludePath(std.Build.LazyPath{ .path = "include" });
    screen.addCSourceFiles(&.{
        "src/ftxui/screen/box.cpp",
        "src/ftxui/screen/color.cpp",
        "src/ftxui/screen/color_info.cpp",
        "src/ftxui/screen/screen.cpp",
        "src/ftxui/screen/string.cpp",
        "src/ftxui/screen/terminal.cpp",
        "src/ftxui/screen/terminal.cpp",
    }, &.{});
    screen.linkLibCpp();
    screen.installHeadersDirectoryOptions(.{
        .source_dir = std.Build.LazyPath{ .path = "include/ftxui/screen" },
        .install_dir = .header,
        .install_subdir = "ftxui/screen",
        .exclude_extensions = &.{".c"},
    });
    b.installArtifact(screen);

    const dom = b.addStaticLibrary(.{
        .name = "dom",
        .target = target,
        .optimize = optimize,
    });
    dom.addIncludePath(std.Build.LazyPath{ .path = "src" });
    dom.addIncludePath(std.Build.LazyPath{ .path = "include" });
    dom.addCSourceFiles(&.{
        "src/ftxui/dom/automerge.cpp",
        "src/ftxui/dom/blink.cpp",
        "src/ftxui/dom/bold.cpp",
        "src/ftxui/dom/hyperlink.cpp",
        "src/ftxui/dom/border.cpp",
        "src/ftxui/dom/box_helper.cpp",
        "src/ftxui/dom/canvas.cpp",
        "src/ftxui/dom/clear_under.cpp",
        "src/ftxui/dom/color.cpp",
        "src/ftxui/dom/composite_decorator.cpp",
        "src/ftxui/dom/dbox.cpp",
        "src/ftxui/dom/dim.cpp",
        "src/ftxui/dom/flex.cpp",
        "src/ftxui/dom/flexbox.cpp",
        "src/ftxui/dom/flexbox_config.cpp",
        "src/ftxui/dom/flexbox_helper.cpp",
        "src/ftxui/dom/focus.cpp",
        "src/ftxui/dom/frame.cpp",
        "src/ftxui/dom/gauge.cpp",
        "src/ftxui/dom/graph.cpp",
        "src/ftxui/dom/gridbox.cpp",
        "src/ftxui/dom/hbox.cpp",
        "src/ftxui/dom/inverted.cpp",
        "src/ftxui/dom/linear_gradient.cpp",
        "src/ftxui/dom/node.cpp",
        "src/ftxui/dom/node_decorator.cpp",
        "src/ftxui/dom/paragraph.cpp",
        "src/ftxui/dom/reflect.cpp",
        "src/ftxui/dom/scroll_indicator.cpp",
        "src/ftxui/dom/separator.cpp",
        "src/ftxui/dom/size.cpp",
        "src/ftxui/dom/spinner.cpp",
        "src/ftxui/dom/strikethrough.cpp",
        "src/ftxui/dom/table.cpp",
        "src/ftxui/dom/text.cpp",
        "src/ftxui/dom/underlined.cpp",
        "src/ftxui/dom/underlined_double.cpp",
        "src/ftxui/dom/util.cpp",
        "src/ftxui/dom/vbox.cpp",
    }, &.{});
    dom.linkLibrary(screen);
    dom.linkLibCpp();
    dom.installHeadersDirectoryOptions(.{
        .source_dir = std.Build.LazyPath{ .path = "include/ftxui/dom" },
        .install_dir = .header,
        .install_subdir = "ftxui/dom",
        .exclude_extensions = &.{".c"},
    });
    b.installArtifact(dom);

    const component = b.addStaticLibrary(.{
        .name = "component",
        .target = target,
        .optimize = optimize,
    });
    component.addIncludePath(std.Build.LazyPath{ .path = "src" });
    component.addIncludePath(std.Build.LazyPath{ .path = "include" });
    component.addCSourceFiles(&.{
        "src/ftxui/component/animation.cpp",
        "src/ftxui/component/button.cpp",
        "src/ftxui/component/catch_event.cpp",
        "src/ftxui/component/checkbox.cpp",
        "src/ftxui/component/collapsible.cpp",
        "src/ftxui/component/component.cpp",
        "src/ftxui/component/component_options.cpp",
        "src/ftxui/component/container.cpp",
        "src/ftxui/component/dropdown.cpp",
        "src/ftxui/component/event.cpp",
        "src/ftxui/component/hoverable.cpp",
        "src/ftxui/component/input.cpp",
        "src/ftxui/component/loop.cpp",
        "src/ftxui/component/maybe.cpp",
        "src/ftxui/component/menu.cpp",
        "src/ftxui/component/modal.cpp",
        "src/ftxui/component/radiobox.cpp",
        "src/ftxui/component/radiobox.cpp",
        "src/ftxui/component/renderer.cpp",
        "src/ftxui/component/resizable_split.cpp",
        "src/ftxui/component/screen_interactive.cpp",
        "src/ftxui/component/slider.cpp",
        "src/ftxui/component/terminal_input_parser.cpp",
        "src/ftxui/component/util.cpp",
        "src/ftxui/component/window.cpp",
    }, &.{});
    component.linkLibrary(dom);
    component.linkLibCpp();
    component.installHeadersDirectoryOptions(.{
        .source_dir = std.Build.LazyPath{ .path = "include/ftxui/component" },
        .install_dir = .header,
        .install_subdir = "ftxui/component",
        .exclude_extensions = &.{".c"},
    });
    b.installArtifact(component);

    var examples = Examples.init(b, optimize, screen, dom, component);
    examples.install(b);
}

fn root() []const u8 {
    return comptime (std.fs.path.dirname(@src().file) orelse ".") ++ "/";
}

const Compile = std.Build.Step.Compile;

const Examples = struct {
    @"dom/border": *Compile,
    @"dom/border_colored": *Compile,
    @"dom/border_style": *Compile,
    @"dom/canvas": *Compile,
    @"dom/color_gallery": *Compile,
    @"dom/color_info_palette256": *Compile,
    @"dom/color_truecolor_HSV": *Compile,
    @"dom/color_truecolor_RGB": *Compile,
    @"dom/dbox": *Compile,
    @"dom/gauge": *Compile,
    @"dom/gauge_direction": *Compile,
    @"dom/graph": *Compile,
    @"dom/gridbox": *Compile,
    @"dom/hflow": *Compile,
    @"dom/html_like": *Compile,
    @"dom/linear_gradient": *Compile,
    @"dom/package_manager": *Compile,
    @"dom/paragraph": *Compile,
    @"dom/separator": *Compile,
    @"dom/separator_style": *Compile,
    @"dom/size": *Compile,
    @"dom/spinner": *Compile,
    @"dom/style_blink": *Compile,
    @"dom/style_bold": *Compile,
    @"dom/style_color": *Compile,
    @"dom/style_dim": *Compile,
    @"dom/style_gallery": *Compile,
    @"dom/style_hyperlink": *Compile,
    @"dom/style_inverted": *Compile,
    @"dom/style_strikethrough": *Compile,
    @"dom/style_underlined": *Compile,
    @"dom/style_underlined_double": *Compile,
    @"dom/table": *Compile,
    @"dom/vbox_hbox": *Compile,
    @"dom/vflow": *Compile,
    @"component/button_animated": *Compile,
    @"component/button": *Compile,
    @"component/button_in_frame": *Compile,
    @"component/button_style": *Compile,
    @"component/canvas_animated": *Compile,
    @"component/checkbox": *Compile,
    @"component/checkbox_in_frame": *Compile,
    @"component/collapsible": *Compile,
    @"component/composition": *Compile,
    @"component/custom_loop": *Compile,
    @"component/dropdown": *Compile,
    @"component/flexbox_gallery": *Compile,
    @"component/focus": *Compile,
    @"component/focus_cursor": *Compile,
    @"component/gallery": *Compile,
    @"component/homescreen": *Compile,
    @"component/input": *Compile,
    @"component/input_style": *Compile,
    @"component/linear_gradient_gallery": *Compile,
    @"component/maybe": *Compile,
    @"component/menu2": *Compile,
    @"component/menu": *Compile,
    @"component/menu_entries_animated": *Compile,
    @"component/menu_entries": *Compile,
    @"component/menu_in_frame": *Compile,
    @"component/menu_multiple": *Compile,
    @"component/menu_style": *Compile,
    @"component/menu_underline_animated_gallery": *Compile,
    @"component/modal_dialog": *Compile,
    @"component/modal_dialog_custom": *Compile,
    @"component/nested_screen": *Compile,
    @"component/print_key_press": *Compile,
    @"component/radiobox": *Compile,
    @"component/radiobox_in_frame": *Compile,
    @"component/renderer": *Compile,
    @"component/resizable_split": *Compile,
    @"component/slider": *Compile,
    @"component/slider_direction": *Compile,
    @"component/slider_rgb": *Compile,
    @"component/tab_horizontal": *Compile,
    @"component/tab_vertical": *Compile,
    @"component/textarea": *Compile,
    @"component/toggle": *Compile,
    @"component/window": *Compile,
    @"component/with_restored_io": *Compile,

    pub fn init(b: *std.build.Builder, optimize: std.builtin.OptimizeMode, screen: *Compile, dom: *Compile, component: *Compile) Examples {
        var ret: Examples = undefined;

        inline for (@typeInfo(Examples).Struct.fields) |field| {
            comptime var sub: []const u8 = undefined;
            comptime var name: []const u8 = undefined;
            if (comptime std.mem.eql(u8, "dom", field.name[0..3])) {
                sub = field.name[0..3];
                name = field.name[4..];
            } else {
                sub = field.name[0..9];
                name = field.name[10..];
            }

            const path = comptime root() ++ "examples/" ++ sub ++ "/" ++ name ++ ".cpp";

            @field(ret, field.name) = b.addExecutable(.{
                .name = name,
                .optimize = optimize,
            });
            @field(ret, field.name).addCSourceFiles(&.{path}, &.{});
            @field(ret, field.name).addIncludePath(std.Build.LazyPath{ .path = "src" });
            @field(ret, field.name).addIncludePath(std.Build.LazyPath{ .path = "include" });
            @field(ret, field.name).linkLibrary(dom);
            @field(ret, field.name).linkLibrary(component);
            @field(ret, field.name).linkLibrary(screen);
            @field(ret, field.name).linkLibCpp();
        }

        return ret;
    }

    pub fn install(examples: *Examples, b: *std.build.Builder) void {
        inline for (@typeInfo(Examples).Struct.fields) |field| {
            b.installArtifact(@field(examples, field.name));
        }
    }
};
