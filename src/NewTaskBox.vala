namespace Pomodoro {
    public class NewTaskBox : Gtk.Box {
        private Gtk.Entry title_entry;
        private Gtk.Button add_task_button;

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

            title_entry = new Gtk.Entry ();
            title_entry.activate.connect (create_task);
            add_task_button = new Gtk.Button.with_label (_("Add Task"));
            add_task_button.clicked.connect (create_task);
            pack_start (title_entry);
            pack_end (add_task_button, false, false);
        }

        private void create_task () {
            if (title_entry.text.length > 0) {
                Pomodoro.store.add_task (new Pomodoro.Task (title_entry.text));
                title_entry.text = "";
            }
        }
    }
}
