namespace Pomodoro {
    public class TaskBox : Gtk.Box {
        public TaskBox () {
            Object (
                orientation: Gtk.Orientation.VERTICAL,
                spacing: 6
            );

            var task_stack = new TaskStack ();
            var tasks_stack_switcher = new Gtk.StackSwitcher () {
                stack = task_stack,
                margin_left = 12,
                margin_right = 12,
                margin_top = 6,
                margin_bottom = 6,
                halign = Gtk.Align.CENTER
            };
            var new_task_box = new NewTaskBox ();

            pack_start (new_task_box, false, false, 0);
            pack_start (task_stack);
            pack_end (tasks_stack_switcher, false, false, 0);
        }
    }
}
