namespace Pomodoro {
    public static Pomodoro.Store store;
    public class Application : Gtk.Application {
        internal Application () {
            Object (
                application_id: "com.github.lifeiscontent.pomodoro",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        static construct {
            store = new Pomodoro.InMemoryStore ();
            var first_task = new Pomodoro.Task ("Finish this");
            first_task.done = true;
            store.add_task (first_task);
            store.add_task (new Pomodoro.Task ("Be Productive"));
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
