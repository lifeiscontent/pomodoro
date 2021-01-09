namespace Pomodoro {
    public class TaskTreeView : Gtk.TreeView {
        public TaskTreeView () {
            Object (
                headers_visible: false,
                model: Pomodoro.tasks
            );

            var done_renderer = new Gtk.CellRendererToggle ();

            var done_column = new Gtk.TreeViewColumn.with_attributes (
                "Title",
                done_renderer
            ) {
                clickable = true
            };

            done_column.set_cell_data_func (done_renderer, task_done_cell_data_func);

            done_renderer.toggled.connect (toggle_task);

            insert_column (done_column, -1);

            var title_renderer = new Gtk.CellRendererText () {
                editable = true
            };

            title_renderer.edited.connect (update_task_name);

            var title_column = new Gtk.TreeViewColumn.with_attributes (
                "Title",
                 title_renderer,
                 "text",
                 TaskListStore.Column.TITLE,
                 null
            ) {
                expand = true
            };

            title_column.set_cell_data_func (title_renderer, task_title_cell_data_func);

            insert_column (title_column, -1);
        }
        public TaskTreeView.from_all_tasks () {
            this ();
        }

        public TaskTreeView.from_active_tasks () {
            this ();
        }

        public TaskTreeView.from_completed_tasks () {
            this ();
        }

        void toggle_task (string path) {
            Gtk.TreeIter iter;
            bool done;
            Gtk.TreePath tree_path = new Gtk.TreePath.from_string (path);
            if (!model.get_iter (out iter, tree_path)) return;
            model.get (iter, TaskListStore.Column.DONE, out done);
            Pomodoro.tasks.set (iter, TaskListStore.Column.DONE, !done);
        }

        void update_task_name (string path, string new_text) {
            Gtk.TreeIter iter;
            Gtk.TreePath tree_path = new Gtk.TreePath.from_string (path);
            if (!model.get_iter (out iter, tree_path)) return;
            Pomodoro.tasks.set (iter, TaskListStore.Column.TITLE, new_text);
        }

        void task_done_cell_data_func (
            Gtk.CellLayout cell_layout,
            Gtk.CellRenderer cell_renderer,
            Gtk.TreeModel model,
            Gtk.TreeIter iter
        ) {
            var toggle = (Gtk.CellRendererToggle) cell_renderer;
            bool done;
            model.get (iter, TaskListStore.Column.DONE, out done);
            toggle.active = done;
        }

        void task_title_cell_data_func (
            Gtk.CellLayout cell_layout,
            Gtk.CellRenderer cell_renderer,
            Gtk.TreeModel model,
            Gtk.TreeIter iter
        ) {
            var text = (Gtk.CellRendererText) cell_renderer;
            string title;
            model.get (iter, TaskListStore.Column.TITLE, out title);
            text.text = title;
        }
    }
}
