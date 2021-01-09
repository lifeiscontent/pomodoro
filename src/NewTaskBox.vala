namespace Pomodoro {
    public class NewTaskBox : Gtk.Box {
        public NewTaskBox () {
            Object (
                orientation: Gtk.Orientation.HORIZONTAL,
                spacing: 6,
                valign: Gtk.Align.START,
                margin_left: 12,
                margin_right: 12,
                margin_top: 6,
                margin_bottom: 6
            );

            var entry = new Gtk.Entry ();
            var button = new Gtk.Button.with_label (_("Add Task"));

            pack_start (entry);
            pack_end (button, false, false);
        }
    }
}
