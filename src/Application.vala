namespace Pomodoro {
    public static Pomodoro.TaskListStore tasks;
    public class Application : Gtk.Application {
        internal Application () {
            Object (
                application_id: "com.github.lifeiscontent.pomodoro",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        static construct {
            tasks = new Pomodoro.TaskListStore ();
            Gtk.TreeIter iter;
            tasks.append (out iter);
            tasks.set (
                iter,
                TaskListStore.Column.DONE,
                false,
                TaskListStore.Column.TITLE,
                "Finish this"
            );
            tasks.append (out iter);
            tasks.set (
                iter,
                TaskListStore.Column.DONE,
                false,
                TaskListStore.Column.TITLE,
                "Be Productive"
            );
        }

        protected override void activate () {
            var window = new ApplicationWindow (this);
            add_window (window);
            window.show_all ();
        }

        public static int main (string[] args) {
            return new Application ().run (args);
        }
    }
}
