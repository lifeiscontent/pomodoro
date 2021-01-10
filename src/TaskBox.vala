namespace Pomodoro {
    public class TaskBox : Gtk.Box {
        private Gtk.ListStore all_tasks;
        private Gtk.TreeIter all_tasks_iter;
        private Gtk.TreeModelFilter active_tasks;
        private Gtk.TreeModelFilter completed_tasks;

        public TaskBox () {
            Object (
                orientation: Gtk.Orientation.VERTICAL,
                spacing: 6
            );

            all_tasks = new Gtk.ListStore (1, typeof (Task));

            foreach (Task task in Pomodoro.store.tasks) {
                all_tasks.append (out all_tasks_iter);
                all_tasks.set (all_tasks_iter, 0, task);
            }

            Pomodoro.store.task_added.connect (add_task);

            active_tasks = new Gtk.TreeModelFilter (all_tasks, null);
            active_tasks.set_visible_func (active_tasks_visible_func);

            completed_tasks = new Gtk.TreeModelFilter (all_tasks, null);
            completed_tasks.set_visible_func (completed_tasks_visible_func);

            var all_tasks_tree_view = new TaskTreeView ();
            all_tasks_tree_view.set_model (all_tasks);
            all_tasks_tree_view.task_changed.connect (refilter_tree_model_filters);

            var active_tasks_tree_view = new TaskTreeView ();
            active_tasks_tree_view.set_model (active_tasks);
            active_tasks_tree_view.task_changed.connect (refilter_tree_model_filters);

            var completed_tasks_tree_view = new TaskTreeView ();
            completed_tasks_tree_view.set_model (completed_tasks);
            completed_tasks_tree_view.task_changed.connect (refilter_tree_model_filters);

            var tasks_stack = new Gtk.Stack ();

            tasks_stack.add_titled (all_tasks_tree_view, "all", _("All"));
            tasks_stack.add_titled (active_tasks_tree_view, "active", _("Active"));
            tasks_stack.add_titled (completed_tasks_tree_view, "completed", _("Completed"));

            var tasks_stack_switcher = new Gtk.StackSwitcher () {
                stack = tasks_stack,
                margin_left = 12,
                margin_right = 12,
                margin_top = 6,
                margin_bottom = 6,
                halign = Gtk.Align.CENTER
            };

            var new_task_box = new NewTaskBox ();

            pack_start (new_task_box, false, false, 0);
            pack_start (tasks_stack);
            pack_end (tasks_stack_switcher, false, false, 0);
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

        private void refilter_tree_model_filters () {
            active_tasks.refilter ();
            completed_tasks.refilter ();
        }

        private void add_task (Task task) {
            all_tasks.append (out all_tasks_iter);
            all_tasks.set (all_tasks_iter, 0, task);
        }
    }
}
