public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.lifeiscontent.pomodoro",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "Hello World"
        };

        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.row_spacing = 6;

        var button = new Gtk.Button.with_label (_("Click me!"));
        var label = new Gtk.Label (null);

        button.clicked.connect (() => {
            label.label = _("Hello World!");
            button.sensitive = false;
        });

        grid.add (button);
        grid.add (label);

        main_window.add (grid);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
