namespace Pomodoro {
    public class ApplicationWindow : Gtk.ApplicationWindow {
        public ApplicationWindow (Pomodoro.Application application) {
            Object (
                application: application,
                default_height: 300,
                default_width: 300,
                title: "Pomodoro"
            );

            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
            var new_task_box = new NewTaskBox ();
            var tasks_stack = new Gtk.Stack ();

            tasks_stack.add_titled (
                new TaskTreeView.from_all_tasks (),
                "all",
                _("All")
            );
            tasks_stack.add_titled (
                new TaskTreeView.from_active_tasks (),
                "active",
                _("Active")
            );
            tasks_stack.add_titled (
                new TaskTreeView.from_completed_tasks (),
                "completed",
                _("Completed")
            );

            var tasks_stack_switcher = new Gtk.StackSwitcher () {
                stack = tasks_stack,
                margin_left = 12,
                margin_right = 12,
                margin_top = 6,
                margin_bottom = 6,
                halign = Gtk.Align.CENTER
            };

            box.pack_start (new_task_box, false, false, 0);
            box.pack_start (tasks_stack);
            box.pack_end (tasks_stack_switcher, false, false, 0);

            add (box);
        }
    }
}
