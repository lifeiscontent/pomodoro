namespace Pomodoro {
    public abstract class Store : Object {
        public virtual Gee.ArrayList<Task> tasks { get; internal set; default = new Gee.ArrayList<Task> (); }

        public signal void task_added (Task task);
        public signal void task_removed (Task task);

        public abstract void add_task (Task to_add);
        public abstract void remove_task (Task to_remove);

        public new Task get (int index) {
            return tasks[index];
        }

        public new void set (int index, Task task) {
            tasks[index] = task;
        }

        public Gee.Iterator<Task> iterator () {
            return tasks.iterator ();
        }
    }
}
