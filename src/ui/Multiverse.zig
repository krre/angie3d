const Application = @import("../core/Application.zig");

const Multiverse = @This();

app: *Application,

pub fn init(app: *Application) Multiverse {
    return Multiverse{
        .app = app,
    };
}
