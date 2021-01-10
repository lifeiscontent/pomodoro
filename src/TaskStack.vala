namespace Pomodoro {
    public class TaskStack : Gtk.Stack {
        private Gtk.ListStore all_tasks;
        private Gtk.TreeIter all_tasks_iter;
        private Gtk.TreeModelFilter active_tasks;
        private Gtk.TreeModelFilter completed_tasks;

        public TaskStack () {
            all_tasks = new Gtk.ListStore (1, typeof (Task));
            active_tasks = new Gtk.TreeModelFilter (all_tasks, null);
            completed_tasks = new Gtk.TreeModelFilter (all_tasks, null);

            var all_tasks_tree_view = new TaskTreeView ();
            var active_tasks_tree_view = new TaskTreeView ();
            var completed_tasks_tree_view = new TaskTreeView ();

            Pomodoro.store.task_added.connect (add_task);
            all_tasks_tree_view.task_changed.connect (refilter_tasks);
            active_tasks_tree_view.task_changed.connect (refilter_tasks);
            completed_tasks_tree_view.task_changed.connect (refilter_tasks);

            active_tasks.set_visible_func (active_tasks_visible_func);
            completed_tasks.set_visible_func (completed_tasks_visible_func);

            all_tasks_tree_view.set_model (all_tasks);
            active_tasks_tree_view.set_model (active_tasks);
            completed_tasks_tree_view.set_model (completed_tasks);

            foreach (Task task in Pomodoro.store.tasks) {
                all_tasks.append (out all_tasks_iter);
                all_tasks.set (all_tasks_iter, 0, task);
            }

            add_titled (all_tasks_tree_view, "all", _("All"));
            add_titled (active_tasks_tree_view, "active", _("Active"));
            add_titled (completed_tasks_tree_view, "completed", _("Completed"));
        }

        private bool completed_tasks_visible_func (
            Gtk.TreeModel model,
            Gtk.TreeIter iter
        ) {
            Task task;

            model.get (iter, 0, out task);

            if (task == null || !task.done) return false;

            return true;
        }

        private bool active_tasks_visible_func (
            Gtk.TreeModel model,
            Gtk.TreeIter iter
        ) {
            Task task;

            model.get (iter, 0, out task);

            if (task == null || task.done) return false;

            return true;
        }

        private void refilter_tasks () {
            active_tasks.refilter ();
            completed_tasks.refilter ();
        }

        private void add_task (Task task) {
            all_tasks.append (out all_tasks_iter);
            all_tasks.set (all_tasks_iter, 0, task);
        }
    }
}
