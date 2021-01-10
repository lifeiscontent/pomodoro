namespace Pomodoro {
    public class ApplicationWindow : Gtk.ApplicationWindow {
        public ApplicationWindow (Pomodoro.Application application) {
            Object (
                application: application,
                default_height: 300,
                default_width: 300,
                title: "Pomodoro"
            );

            add (new Pomodoro.TaskBox ());
        }
    }
}
