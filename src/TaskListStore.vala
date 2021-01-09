namespace Pomodoro {
    public class TaskListStore : Gtk.ListStore {
        public enum Column {
            DONE,
            TITLE
        }

        public TaskListStore () {
            set_column_types ({
                typeof (bool),
                typeof (string)
            });
        }
    }
}
