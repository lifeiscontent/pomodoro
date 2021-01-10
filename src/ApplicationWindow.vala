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
            var all_tasks = new Gtk.ListStore (1, typeof (Task));
            Gtk.TreeIter all_iter;
            foreach (Task task in Pomodoro.store.tasks) {
                all_tasks.append (out all_iter);
                all_tasks.set (all_iter, 0, task);
            }

            var active_tasks = new Gtk.TreeModelFilter (all_tasks, null);
            active_tasks.set_visible_func (active_tasks_visible_func);
            var completed_tasks = new Gtk.TreeModelFilter (all_tasks, null);
            completed_tasks.set_visible_func (completed_tasks_visible_func);

            var all_tasks_tree_view = new TaskTreeView ();
            all_tasks_tree_view.set_model (all_tasks);
            var active_tasks_tree_view = new TaskTreeView ();
            active_tasks_tree_view.set_model (active_tasks);
            // active_tasks_tree_view.realize.connect(() => {
            //     active_tasks.refilter();
            // });
            var completed_tasks_tree_view = new TaskTreeView ();
            completed_tasks_tree_view.set_model (completed_tasks);
            // completed_tasks_tree_view.realize.connect(() => {
            //     completed_tasks.refilter();
            // });

            tasks_stack.add_titled (
                all_tasks_tree_view,
                "all",
                _("All")
            );
            tasks_stack.add_titled (
                active_tasks_tree_view,
                "active",
                _("Active")
            );
            tasks_stack.add_titled (
                completed_tasks_tree_view,
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

        private bool completed_tasks_visible_func (
            Gtk.TreeModel model,
            Gtk.TreeIter iter
        ) {
            Task task;
            model.get (iter, 0, out task);
            if (task == null) return false;
            if (!task.done) return false;
            return true;
        }

        private bool active_tasks_visible_func (
            Gtk.TreeModel model,
            Gtk.TreeIter iter
        ) {
            Task task;
            model.get (iter, 0, out task);
            if (task == null) return false;
            if (task.done) return false;
            return true;
        }
    }
}
